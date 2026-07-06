-- Synthetic training data. Not valid for greenhouse-gas accounting.
USE ef_practice;

INSERT INTO fuel_items (item_id, item_name, class_l1, class_l2, class_l3) VALUES
(1, 'Training Fuel A', 'Energy', 'Fuel combustion', 'Stationary combustion'),
(2, 'Training Fuel B', 'Energy', 'Fuel combustion', 'Stationary combustion'),
(3, 'Training Fuel C', 'Energy', 'Fuel combustion', 'Stationary combustion');

INSERT INTO flows (flow_code, flow_name, is_gwp_combined) VALUES
('CO2',  'Carbon dioxide', FALSE),
('CH4',  'Methane', FALSE),
('N2O',  'Nitrous oxide', FALSE),
('CO2e', 'CO2 equivalent (GWP100)', TRUE);

-- Item 3 deliberately has no factor rows to demonstrate missing-data joins.
INSERT INTO emission_factors
  (ef_id, item_id, flow_code, value, unit_numerator, unit_denominator, geography, ref_year)
VALUES
('SYN001', 1, 'CO2',  3000.000000000, 'kgCO2',  'tonne', 'TEST', 2026),
('SYN002', 1, 'CH4',     0.150000000, 'kgCH4',  'tonne', 'TEST', 2026),
('SYN003', 1, 'N2O',     0.030000000, 'kgN2O',  'tonne', 'TEST', 2026),
('SYN004', 1, 'CO2e', 3012.000000000, 'kgCO2e', 'tonne', 'TEST', 2026),
('SYN005', 1, 'CO2',     0.240000000, 'kgCO2',  'kWh',   'TEST', 2026),
('SYN006', 1, 'CH4',     0.000012000, 'kgCH4',  'kWh',   'TEST', 2026),
('SYN007', 1, 'N2O',     0.000002400, 'kgN2O',  'kWh',   'TEST', 2026),
('SYN008', 1, 'CO2e',    0.241000000, 'kgCO2e', 'kWh',   'TEST', 2026),
('SYN009', 2, 'CO2',  3200.000000000, 'kgCO2',  'tonne', 'TEST', 2026),
('SYN010', 2, 'CH4',     0.130000000, 'kgCH4',  'tonne', 'TEST', 2026);

