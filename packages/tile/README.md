# Pyro Quick Settings Tile Package Suite (`packages/tile`)

The `packages/tile` suite encapsulates Android status bar pulldown Quick Settings Tile (`TileService`) for toggling call interception / quiet mode into a standalone 5-layer package suite.

---

## 📁 Package Topology

```text
packages/tile/
├── pyro_tile_protocol/   # Tile state enums, info entities & adapter contracts
├── pyro_tile_hub/        # IoC Locator & Tile state manager (TileHub.instance)
├── pyro_tile_driver/     # Android TileService native driver
├── pyro_tile_connector/  # Facade assembly connector (TileConnectors.ensureMounted())
└── pyro_tile_ui/         # Quick Settings Tile switch cards & status widgets
```

---

## 📄 License

Proprietary / All Rights Reserved - Pyro Magma Workspace
