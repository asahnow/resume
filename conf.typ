#let conf(
  name: none,
  phone: none,
  email: none,
  linkedin: none
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

    show title: smallcaps
    show title: set text(
      size: 2em,
      weight: "regular"
    )
    show title: set align(center)

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

    if linkedin != none {
      link("https://www." + linkedin)[#linkedin]
    } else if contact.linkedin != none {
      link("https://www." + contact.linkedin)[#contact.linkedin]
    }

    body
  }
}
