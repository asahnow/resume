#let name-part(
  part,
  initial-boost,
  tracking,
  initial-gap
) = {
  if part == "" {
    none
  } else {
    let init = part.at(0)
    let rest = part.slice(1)

    text(
      size: 1em * initial-boost,
      features: ("smcp",),
      tracking: tracking
    )[#lower(init)] + h(initial-gap) + text(
      features: ("smcp",),
      tracking: tracking
    )[#lower(rest)]
  }
}

#let name-word(
  word,
  initial-boost,
  tracking,
  initial-gap,
  hyphen-gap
) = box[
  #for (i, part) in word.split("-").enumerate() {
    if i > 0 {
      h(hyphen-gap)
      text(features: ("smcp",))[-]
      h(hyphen-gap)
    }

    name-part(
      part,
      initial-boost,
      tracking,
      initial-gap
    )
  }
]

#let resume-title-name(
  name,
  size,
  initial-boost,
  tracking,
  initial-gap,
  word-gap,
  hyphen-gap
) = align(center)[
  #text(size: size, weight: 500)[
    #for (i, word) in name.split(" ").enumerate() {
      if i > 0 {
        h(word-gap)
      }

      name-word(
        word,
        initial-boost,
        tracking,
        initial-gap,
        hyphen-gap
      )
    }
  ]
]

#let conf(
  name: none,
  phone: none,
  email: none,
  linkedin: none,

  name-size: 2em,
  name-initial-boost: 115%,
  name-tracking: 2em * 4%,
  name-initial-gap: 2em * 2.5%,
  name-word-gap: 0.4em,
  name-hyphen-gap: 2em * 2%,
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

    show title: _ => resume-title-name(
      name,
      name-size,
      name-initial-boost,
      name-tracking,
      name-initial-gap,
      name-word-gap,
      name-hyphen-gap
    )

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
