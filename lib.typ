// Modified from https://github.com/stuxf/basic-typst-resume-template/tree/main

#let resume(
  author: "",
  author-position: left,
  personal-info-position: left,
  location: "",
  email: "",
  phone: "",
  personal-site: "",
  linkedin: "",
  accent-color: "#000000",
  body-font: "Inter 18pt",
  heading-font: "Bricolage Grotesque",
  paper: "us-letter",
  body,
) = {
  // Metadata
  set document(author: author, title: author)
 
  // Document-wide formatting
  set text(
    font: body-font,
    lang: "en",
    // Disable ligatures for improved ATS legibility
    ligatures: false
  )

  set page(
    // margin: 0.5in,
    margin: (
      top: 0.5in,
      bottom: 0.25in,
      x: 0.5in,
    ),
    paper: paper,
  )

  // Bold text has slightly less weight
  set strong(delta: 200)

  show heading: set text(
    fill: rgb(accent-color),
    font: heading-font,
  )

  show link: set text(fill: rgb(accent-color))
  show link: underline

  // Section titles
  show heading.where(level: 2): it => [
    #pad(top: 0pt, bottom: -10pt, it.body)
    #line(length: 100%, stroke: 1pt)
  ]

  // Name
  show heading.where(level: 1): it => [
    #set align(author-position)
    #set text(
      weight: 700,
      size: 20pt,
    )
    #pad(it.body)
  ]

  [= #(author)]

  // Personal info
  let contact-item(value, prefix: "", link-type: "") = {
    if value != "" {
      if link-type != "" {
        link(link-type + value)[#(prefix + value)]
      } else {
        value
      }
    }
  }

  pad(
    top: 0.25em,
    align(personal-info-position)[
      #{
        let items = (
          contact-item(location),
          contact-item(phone),
          contact-item(email, link-type: "mailto:"),
          contact-item(personal-site, link-type: "https://"),
          contact-item(linkedin, link-type: "https://linkedin.com/"),
        )
        items.filter(x => x != none).join("  " + sym.slash.double + "  ")
      }
    ],
  )

  // Main body
  set par(justify: true)
  
  body
}

// Generic two by two component
#let generic-two-by-two(
  top-left: "",
  top-right: "",
  bottom-left: "",
  bottom-right: "",
) = {
  [
    #top-left #h(1fr) #top-right \
    #bottom-left #h(1fr) #bottom-right
  ]
}

// Avoid use of "--" ligature for ATS legibility
#let dates-helper(
  start-date: "",
  end-date: "",
) = {
  start-date + " " + $dash.en$ + " " + end-date
}

#let edu(
  dates: "",
  degree: "",
  honors: "",
  institution: "",
  location: "",
) = {
  generic-two-by-two(
    top-left: strong(institution),
    top-right: strong(dates),
    bottom-left: (degree),
    bottom-right: emph(location),
  )
}

#let work(
  company: "",
  dates: "",
  location: "",
  title: "",
) = {
  generic-two-by-two(
    top-left: strong(company),
    top-right: strong(dates),
    bottom-left: emph(title),
    bottom-right: emph(location),
  )
}
