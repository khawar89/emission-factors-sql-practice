USE ef_practice;

-- Exercise 1: INNER JOIN across all three tables.
SELECT ef.ef_id, fi.item_name, fl.flow_name, ef.value,
       ef.unit_numerator, ef.unit_denominator
FROM emission_factors ef
INNER JOIN fuel_items fi ON ef.item_id = fi.item_id
INNER JOIN flows fl ON ef.flow_code = fl.flow_code
ORDER BY fi.item_name, fl.flow_name;

-- Exercise 2: find fuel items without emission-factor rows.
SELECT fi.item_id, fi.item_name
FROM fuel_items fi
LEFT JOIN emission_factors ef ON fi.item_id = ef.item_id
WHERE ef.ef_id IS NULL;

-- Exercise 3: INNER JOIN using matching column names.
SELECT ef.ef_id, fi.item_name, fl.flow_name, ef.value,
       ef.unit_numerator, ef.unit_denominator
FROM emission_factors ef
INNER JOIN fuel_items fi USING (item_id)
INNER JOIN flows fl USING (flow_code)
ORDER BY fi.item_name, fl.flow_name;

-- Exercise 4: NATURAL JOIN. This is fragile because any newly shared
-- column name silently becomes an additional join condition.
SELECT ef_id, item_name, flow_name, value,
       unit_numerator, unit_denominator
FROM emission_factors
NATURAL JOIN fuel_items
NATURAL JOIN flows
ORDER BY item_name, flow_name;

-- Exercise 5: compare CO2 and CO2e factors with the same denominator.
SELECT fi.item_name, co2.unit_denominator,
       co2.value AS co2_factor,
       co2e.value AS co2e_factor,
       co2e.value / co2.value AS co2e_co2_ratio
FROM emission_factors co2
INNER JOIN emission_factors co2e
  ON co2.item_id = co2e.item_id
 AND co2.unit_denominator = co2e.unit_denominator
INNER JOIN fuel_items fi ON co2.item_id = fi.item_id
WHERE co2.flow_code = 'CO2'
  AND co2e.flow_code = 'CO2e'
ORDER BY fi.item_name, co2.unit_denominator;

-- Exercise 6: compare tonne- and kWh-basis CO2 factors.
SELECT fi.item_name,
       tonne.value AS co2_per_tonne,
       kwh.value AS co2_per_kwh,
       ROUND(tonne.value / kwh.value, 0) AS implied_kwh_per_tonne
FROM emission_factors tonne
INNER JOIN emission_factors kwh
  ON tonne.item_id = kwh.item_id
 AND tonne.flow_code = kwh.flow_code
INNER JOIN fuel_items fi ON tonne.item_id = fi.item_id
WHERE fi.item_id = 1
  AND tonne.flow_code = 'CO2'
  AND tonne.unit_denominator = 'tonne'
  AND kwh.unit_denominator = 'kWh';

-- Exercise 7: multiple-table join with compound filters.
SELECT ef.ef_id, fi.item_name, fl.flow_name, ef.value,
       ef.unit_numerator, ef.unit_denominator
FROM emission_factors ef
INNER JOIN fuel_items fi ON ef.item_id = fi.item_id
INNER JOIN flows fl ON ef.flow_code = fl.flow_code
WHERE fi.class_l1 = 'Energy'
  AND fl.is_gwp_combined = FALSE
ORDER BY fi.item_name, fl.flow_name;

-- Exercise 8: legacy implicit join syntax. Explicit JOIN...ON is preferred
-- because it separates relationships from filters and reduces join mistakes.
SELECT ef.ef_id, fi.item_name, fl.flow_name, ef.value,
       ef.unit_numerator, ef.unit_denominator
FROM emission_factors ef, fuel_items fi, flows fl
WHERE ef.item_id = fi.item_id
  AND ef.flow_code = fl.flow_code
ORDER BY fi.item_name, fl.flow_name;

-- Exercise 9: audit theoretical, actual, and missing item-flow combinations.
SELECT 'Theoretical combinations' AS measure, COUNT(*) AS row_count
FROM fuel_items CROSS JOIN flows
UNION ALL
SELECT 'Actual distinct combinations', COUNT(DISTINCT item_id, flow_code)
FROM emission_factors
UNION ALL
SELECT 'Missing combinations', COUNT(*)
FROM fuel_items fi
CROSS JOIN flows fl
LEFT JOIN emission_factors ef
  ON fi.item_id = ef.item_id
 AND fl.flow_code = ef.flow_code
WHERE ef.ef_id IS NULL;

-- Exercise 10a: UNION removes duplicate result rows.
SELECT ef_id, item_id, flow_code, value, unit_numerator, unit_denominator
FROM emission_factors
WHERE unit_denominator = 'tonne'
UNION
SELECT ef_id, item_id, flow_code, value, unit_numerator, unit_denominator
FROM emission_factors
WHERE unit_denominator = 'kWh';

-- Exercise 10b: UNION ALL retains duplicates and avoids deduplication work.
-- Counts match here because the tonne and kWh subsets cannot overlap.
SELECT ef_id, item_id, flow_code, value, unit_numerator, unit_denominator
FROM emission_factors
WHERE unit_denominator = 'tonne'
UNION ALL
SELECT ef_id, item_id, flow_code, value, unit_numerator, unit_denominator
FROM emission_factors
WHERE unit_denominator = 'kWh';

