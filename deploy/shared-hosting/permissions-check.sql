-- Run only in an EMPTY hosting test database using phpMyAdmin.
-- No personal data. Requires CREATE VIEW, CREATE ROUTINE and EXECUTE.
-- Do not continue migration if any statement fails; retain the error privately.
CREATE TABLE tl_hosting_probe_20261117 (id INT PRIMARY KEY);
INSERT INTO tl_hosting_probe_20261117 VALUES (1);
CREATE VIEW tl_hosting_probe_view_20261117 AS SELECT id FROM tl_hosting_probe_20261117;
CREATE FUNCTION tl_hosting_probe_fn_20261117 (value_in INT)
RETURNS INT DETERMINISTIC NO SQL RETURN value_in;
SELECT tl_hosting_probe_fn_20261117(id) AS expected_one FROM tl_hosting_probe_view_20261117;
DROP FUNCTION tl_hosting_probe_fn_20261117;
DROP VIEW tl_hosting_probe_view_20261117;
DROP TABLE tl_hosting_probe_20261117;
