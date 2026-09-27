# Concept overview

Status: editorial draft reconstructed from the founding discussion; not the
previously prepared whitepaper or a normative specification.

## Problem and proposal

APIs, events, data products, business terminology and ownership are often described
in different places. Consumers must reconstruct the meaning and responsibilities
behind an interface. Semantic Mesh proposes explicit, versioned domain contracts
that connect these descriptions at domain boundaries.

Domain-Driven Design supplies bounded contexts and their ubiquitous language.
Different contexts may use the same word differently. A semantic relationship
must describe that difference rather than silently treating the concepts as equal.
Domain ownership extends beyond analytical data to capabilities, APIs, events,
business objects, KPIs and agent-facing services where useful.

## Domain knowledge and contracts

A Domain Knowledge Graph is a logical representation of domain concepts and
relationships, not a mandatory database product. Teams should reuse existing
glossaries, interface definitions, domain models and other maintained artifacts.
Tools and AI can propose mappings; accountable domain experts validate meaning.
Teams should gain useful discovery and change-impact information incrementally,
without first designing a complete ontology.

A Semantic Domain Contract exposes a selected, reviewed boundary description.
It is not a dump of internal domain knowledge. A registry can index published
contracts while domains retain authority over their models and operational data.
Metadata access and operational authorization remain separate concerns: describing
an action or policy does not grant permission or enforce it.

## A first useful scenario

Use fictional Claims and Policy domains. Claims needs to check policy coverage.
The Policy domain describes its coverage-check capability, relevant concepts,
owner and API reference. Claims records which version it consumes and how its
claim terminology maps to the Policy context. An agent can discover that interface
and its constraints, but still needs runtime authorization to invoke it.

The first demonstration should make one dependency and one incompatible meaning
change visible. This is a testable starting point, not evidence that the complete
enterprise can already be modeled automatically.
