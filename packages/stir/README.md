# Pyro STIR/SHAKEN Package Suite (`packages/stir`)

The `packages/stir` suite encapsulates STIR/SHAKEN caller authentication status verification (`callerNumberVerificationStatus`) from `StirChecker.kt` into a standalone, 5-layer decoupled package suite.

---

## 📁 Package Topology

```text
packages/stir/
├── pyro_stir_protocol/   # Abstract contracts, zero-dependency models, enums & adapters
├── pyro_stir_hub/        # IoC Locator & STIR verification state manager (StirHub.instance)
├── pyro_stir_driver/     # Native Android Call.Details.callerNumberVerificationStatus driver
├── pyro_stir_connector/  # Facade assembly connector (StirConnectors.ensureMounted())
└── pyro_stir_ui/         # STIR verification badges & status indicators
```

---

## 📄 License

Proprietary / All Rights Reserved - Pyro Magma Workspace
