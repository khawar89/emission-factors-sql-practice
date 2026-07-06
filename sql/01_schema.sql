CREATE DATABASE IF NOT EXISTS ef_practice;
USE ef_practice;

CREATE TABLE fuel_items (
  item_id    INT PRIMARY KEY,
  item_name  VARCHAR(100) NOT NULL,
  class_l1   VARCHAR(50),
  class_l2   VARCHAR(50),
  class_l3   VARCHAR(50)
);

CREATE TABLE flows (
  flow_code        VARCHAR(10) PRIMARY KEY,
  flow_name        VARCHAR(50) NOT NULL,
  is_gwp_combined  BOOLEAN NOT NULL
);

CREATE TABLE emission_factors (
  ef_id             VARCHAR(10) PRIMARY KEY,
  item_id           INT NOT NULL,
  flow_code         VARCHAR(10) NOT NULL,
  value             DECIMAL(18,9) NOT NULL,
  unit_numerator    VARCHAR(10) NOT NULL,
  unit_denominator  VARCHAR(10) NOT NULL,
  geography         VARCHAR(10),
  ref_year          SMALLINT,
  FOREIGN KEY (item_id) REFERENCES fuel_items(item_id),
  FOREIGN KEY (flow_code) REFERENCES flows(flow_code)
);

