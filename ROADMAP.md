# Roadmap

## 1. Reviewable project foundation — this proposal

Repository navigation, contribution guidance, founding governance, RFC process,
concept overview and explicit publication status. Review licensing separately.

## 2. Whitepaper and principles

The author has identified Whitepaper v0.3 (2026-08-25) as the working source.
Its seven Semantic Mesh principles in chapter 10 are translated into English in `docs/principles/`.
These are distinct from the twelve DCA principles; adopting or reconciling DCA
principles is not a publication prerequisite. Review the complete whitepaper for
publication in English and confirm references and license scope before a formal release.

## 3. Website

Build the website in this repository after content review. Provide a concise
landing page, whitepaper, principles and visible GitHub feedback/edit links.
An Astro-based implementation is a candidate, not an installed dependency.
Done when local production build, mobile layout, navigation and accessibility
checks pass. Domain/DNS changes and deployment are separate visible steps.

## 4. Domain Contract exploration

Develop a minimal core around one fictional cross-domain use case. Compare reuse
of existing interface and data-contract formats before inventing new syntax.
Done when examples, versioning and semantic mapping rules can be validated.
Create a separate `domain-contract` repository when this work has concrete content.

## Public launch checklist

- Approved whitepaper and principles with source references.
- Explicit license texts, scope and attribution.
- Working issue/PR paths and confirmed conduct-reporting route.
- Verified repository settings and suitable protection for `main`.
- Reviewed website build and deliberate deployment/domain configuration.
- Honest distinction between vision, draft specification and running software.
