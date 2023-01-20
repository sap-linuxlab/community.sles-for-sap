-- This query finds the number of tiers of replication are configured.
-- If more than one is discovered, then the role cannot continue
SELECT COUNT(DISTINCT(TIER)) AS TIERS FROM M_SYSTEM_REPLICATION;
