#let conf(
  name: none,
  phone: none,
  email: none
) = {
  assert(
    name != none,
    message: "conf requires option `name`."
  )

  body => {
    set page(
      margin: (
        bottom: 1in,
        rest: 0.75in
      ),
      paper: "us-letter"
    )

    set text(
      font: "TeX Gyre Pagella",
      size: 11pt
    )

    set document(
      title: name
    )

    show title: it => align(center, it)

    title()

    let contact = yaml("contact.yaml")

    if phone != none {
      phone.replace("-", sym.dash.en)
    } else if contact.phone != none {
      str(contact.phone).replace("-", sym.dash.en) 
    }

    if email != none {
      link("mailto:" + email)
    } else if contact.email != none {
      link("mailto:" + contact.email)
    }

    body
  }
}
