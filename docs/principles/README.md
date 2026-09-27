# Seven principles of Semantic Mesh

Source: Azmir Abdi, *Semantic Mesh*, Whitepaper v0.3, dated 2026-08-25,
chapter 10. Source status: concept draft for semanticmesh.io.
The following is an English translation of the seven principles in that chapter,
preserving their order and meaning.

These distinct Semantic Mesh principles guide the concept. The twelve DCA
principles take a different perspective and are neither adopted one-to-one nor
treated as a prerequisite for publication.

## Principle 1: Business responsibility belongs to the domain

The domain that understands and changes a business service is also responsible
for its contract. Central teams can provide standards, a platform and guidance,
but cannot sustainably maintain the meaning of another domain's business concepts.

Ownership means more than a name in a catalog. The domain must be reachable,
manage changes, stand behind its quality commitments and respond to consumer
feedback.

## Principle 2: What a domain offers is published through contracts

A domain should not expose services for external use solely through implicit
knowledge or incidental implementation details. APIs, data products, business
events, process handoffs and AI agents receive their own contracts.

Not everything internal needs to be published. The boundary is what matters:
once others are expected to rely on a service, it needs a contract.

## Principle 3: The Domain Contract is modular and extensible

The Domain Contract is not a large central document. It connects independent
subcontracts and can grow with the enterprise. A new contract type is added when
a real problem justifies it.

This keeps the concept open to future requirements without making a complete
enterprise metamodel a barrier to getting started.

## Principle 4: Meaning is local; interoperability emerges at the boundaries

Each domain may have its own ubiquitous language. Semantic Mesh does not impose
a global canonical model. Where domains collaborate, however, differences in
meaning must be visible and translatable.

This rule protects both business precision and collaboration across the enterprise.

## Principle 5: Contracts are machine-readable, versioned and verifiable

People must be able to understand a contract, but it must not consist solely of
free text. Tools should be able to process identities, relationships, versions,
quality rules and lifecycle information.

The more closely a contract is integrated with development, testing and operations,
the lower the risk that its description diverges from reality.

## Principle 6: Shared standards are enforced through federated governance and automation wherever possible

Enterprise-wide rules focus on interoperability, security, ownership and the
ability to accommodate change. They are built into the platform as templates,
profiles and automated checks.

Manual governance is reserved for substantive business conflicts and high risks.

## Principle 7: The mesh grows through measurable value

Semantic Mesh is not introduced through a comprehensive model developed over
several years. It starts with a specific domain, value stream, data product,
integration landscape or AI agent where missing meaning creates costs or risks
today.

Additional contracts and semantic depth are added when they generate tangible
value for consumers and domains.
