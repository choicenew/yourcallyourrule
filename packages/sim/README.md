# Pyro SIM Package Suite (`packages/sim`)

The `packages/sim` suite provides dual-SIM card detection, SIM subscription reading (`sim_reader` & `sim_card_code` integration), carrier MCC/MNC parsing, and SIM slot rule filtering built according to the **Pyro Workspace Package Architecture Protocol**.

---

## 📁 Package Topology

```text
packages/sim/
├── pyro_sim_protocol/   # Abstract contracts, zero-dependency data models, enums & adapters
├── pyro_sim_hub/        # IoC Locator & SIM subscription state manager (SimHub.instance)
├── pyro_sim_driver/     # Native Android SubscriptionManager & TelephonyCallback driver
├── pyro_sim_connector/  # Facade assembly connector (SimConnectors.ensureMounted())
└── pyro_sim_ui/         # SIM card badges, slot selector widgets & SIM management page
```

---

## 📄 License

Proprietary / All Rights Reserved - Pyro Magma Workspace
