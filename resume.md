# Reishi Mitani

Tokyo, Japan  
Email: reishim0731@gmail.com | LinkedIn: https://www.linkedin.com/in/reishi-mitani-000232189/

---

## Summary

Backend and platform engineer focused on applied ML systems, data infrastructure, and production reliability.  
Experienced in integrating machine-learning pipelines into large-scale services, improving observability for high-traffic APIs, and leading data-model and storage migrations.  
Currently working at Indeed on taxonomy and metadata platforms supporting ML-driven features at scale.  
Fluent in English and Japanese; professional proficiency in Chinese.

---

## Experience

### Software Engineer — Indeed Technologies Japan

*2023 – Present*

Work on backend platforms and data infrastructure powering ML-driven metadata and taxonomy services.

**ML platform integration**

* Contributed to the migration from rule-based attribute extraction to model-based extraction using transformer models (MMBERT)  
* Implemented backend logic to reconcile model outputs with legacy pipelines and ensure safe rollout  
* Supported staged production deployment and helped improve extraction quality and coverage while maintaining API compatibility

**Observability & reliability at scale**

* Improved logging and monitoring for metadata APIs handling ~800M requests/day  
* Led reductions in redundant error logging, lowering Datadog costs and improving signal-to-noise for incidents  
* Designed monitoring thresholds and contributed to SLO/latency analysis workflows for on-call engineers

**Data platform modernization**

* Led design and migration of taxonomy snapshot artifacts to a structured JSON format  
* Reduced artifact size from ~550MB to ~45MB, improving distribution, parsing speed, and debugging workflows  
* Coordinated migrations across downstream services and external consumers

**Graph database migration**

* Led POC and core importer for migrating taxonomy graph data from Neo4j to NebulaGraph  
* Implemented large-scale node/relationship import pipelines (~600k nodes, ~4M edges)  
* Contributed to schema mapping decisions and validation workflows to ensure data parity during dual-write rollout

**Tech stack:** Java, Kotlin, Go, MongoDB, Neo4j, AWS, gRPC, Datadog, Pytorch, Tensorflow, Python

---

### IoT Security Engineer (Part-time)

*2022 – Present*

Work on embedded security and device identity systems.

* Integrated Sony Spresense and STM32 boards into secure device pipelines  
* Implemented decentralized-identity-based device authentication flows  
* Built communication and cryptographic handling logic for constrained devices

**Tech:** C, Embedded Systems, Cryptography, DID, IoT Security

---

## Education

**M.S. Interdisciplinary Information Studies**  
University of Tokyo, 2021 Apr. - 2023 Mar.

**B.Eng. Systems Innovation**  
University of Tokyo, 2016 Apr. - 2021 Mar.

---

## Skills

**Languages:** Java, Kotlin, Go, TypeScript, C, Python  
**Infra/Data:** MongoDB, Neo4j, AWS, distributed data pipelines  
**Specialties:** ML integration, backend platforms, observability, system migrations, data modeling

**Languages spoken:**  
English (fluent, TOEFL iBT 117)  
Japanese (native)  
Chinese (advanced, HSK6)
