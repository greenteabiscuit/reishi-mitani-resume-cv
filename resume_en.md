# Reishi Mitani

Tokyo, Japan  
Email: reishim0731@gmail.com | LinkedIn: linkedin.com/in/reishi-mitani-000232189 | GitHub: github.com/greenteabiscuit

---

## Summary

Software and systems engineer focused on applied ML systems, data infrastructure, embedded security, and production reliability.  
Experienced in integrating machine-learning pipelines into large-scale services, improving observability for high-traffic APIs, and building secure infrastructure for constrained IoT environments.  
Currently working at Indeed on taxonomy, classification, and metadata platforms supporting ML-driven features at scale.  
Fluent in English and Japanese; advanced Chinese proficiency (HSK6).

---

## Experience

### Software Engineer — Indeed Technologies Japan

*Apr 2023 – Present*

Work on backend platforms and data infrastructure powering ML-driven metadata and taxonomy services.

**ML and taxonomy platform integration**

* Architected and scaled AI/LLM-powered job and skills taxonomy workflows using occupation-specific questionnaires to capture structured qualification data  
* Led a project extracting important attributes such as administrative divisions using transformer models (MMBERT) and AWS SageMaker  
* Implemented backend logic to reconcile model outputs with legacy pipelines and ensure safe rollout  
* Designed rule-based override and eligibility systems that enabled non-engineering teams to correct misclassified content and improve downstream retrieval signals

**Business impact and experimentation**

* Drove A/B-tested improvements including an 18% increase in applications started per user, an 11% increase in activated job seekers, and a 9% reduction in low/zero-result search pages  
* Partnered with Product, Data Science, and Taxonomy teams to ship cross-market improvements in user and job understanding without performance regressions

**Observability & reliability at scale**

* Improved logging and monitoring for metadata APIs handling ~800M requests/day  
* Led reductions in redundant error logging, lowering Datadog costs and improving signal-to-noise for incidents  
* Designed monitoring thresholds and contributed to SLO/latency analysis workflows for on-call engineers  
* Optimized taxonomy data pipelines and search/indexing infrastructure, reducing critical sync time by 75% from ~6 minutes to ~1.5 minutes while scaling to thousands of attributes

**Data platform modernization**

* Led design and migration of taxonomy snapshot artifacts to a structured JSON format  
* Reduced artifact size from ~550MB to ~45MB, improving distribution, parsing speed, and debugging workflows  
* Coordinated migrations across downstream services and external consumers

**Graph database migration**

* Led POC and core importer for migrating taxonomy graph data from Neo4j to NebulaGraph  
* Implemented large-scale node/relationship import pipelines (~600k nodes, ~4M edges)  
* Contributed to schema mapping decisions and validation workflows to ensure data parity during dual-write rollout

**Tech stack:** Java, Kotlin, Go, MongoDB, Neo4j, AWS, SageMaker, gRPC, Datadog, PyTorch, TensorFlow, Python

---

### Senior Systems Engineer (Freelance) — Scurid

*Jul 2022 – Present*

Lead embedded systems and backend engineering for Scurid's IoT security and identity platform.

* Primary developer and maintainer of microscurid-c, Scurid's C-based security library for resource-constrained microcontrollers  
* Implemented TLS connectivity, cryptographic signature generation and verification, and nanopb protobuf messaging for constrained devices  
* Led porting of MicroScurid-C to Sony Spresense (ARM Cortex-M4F), including MQTT signature verification endpoints, cryptographic integration, and hardware demo development  
* Designed automated server certificate provisioning via GCP Certificate Authority Service and runtime TLS certificate reloads for zero-downtime rotation in Kubernetes deployments  
* Managed GKE deployments, Helm charts, Bitbucket CI/CD pipelines, narrow rollout validation, and production debugging  
* Contributed to SSH tunneling, agent log upload systems, gRPC services, Azure IoT Hub integration, InfluxDB/CockroachDB configuration, and DID document support

**Tech:** C, Go, Embedded Systems, TLS/mTLS, mbedTLS, secp256k1, Protobuf/nanopb, MQTT, Kubernetes/GKE, Helm, GCP, Azure IoT Hub, DID, IoT Security

---

## Education

**M.S. Interdisciplinary Information Studies**  
University of Tokyo, Apr 2021 – Mar 2023

**B.Eng. Systems Innovation**  
University of Tokyo, Apr 2016 – Mar 2021

---

## Skills

**Programming Languages:** Java, Kotlin, Go, TypeScript, C, Python, SQL  
**Infra/Data:** MongoDB, Neo4j, InfluxDB, CockroachDB, AWS, GCP, Kubernetes/GKE, Docker, Helm, distributed data pipelines, search/indexing systems  
**Protocols/Security:** gRPC, Protobuf/nanopb, MQTT, LoRaWAN, SSH tunneling, TLS/mTLS, mbedTLS, secp256k1, DID  
**Specialties:** ML integration, AI/LLM taxonomies, classification systems, backend platforms, observability, embedded systems, system migrations, data modeling

**Spoken Languages:**  
English (fluent, TOEFL iBT 117)  
Japanese (native)  
Chinese (advanced, HSK6)
