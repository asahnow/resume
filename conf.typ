#let conf(
  name: none,
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

    if email != none [
      #link("mailto:" + email)
    ]

    body
  }
}
