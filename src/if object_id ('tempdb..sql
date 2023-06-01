IF object_id ('tempdb..#temptable1') IS NOT NULL DROP TABLE #temptable1
IF object_id ('tempdb..#temptable2') IS NOT NULL DROP TABLE #temptable2
IF object_id ('tempdb..#temptable3') IS NOT NULL DROP TABLE #temptable3
IF object_id ('tempdb..#temptable4') IS NOT NULL DROP TABLE #temptable4
IF object_id ('tempdb..#temptable4a') IS NOT NULL DROP TABLE #temptable4a
IF object_id ('tempdb..#temptable5') IS NOT NULL DROP TABLE #temptable5
IF object_id ('tempdb..#temptable6') IS NOT NULL DROP TABLE #temptable6
IF object_id ('tempdb..#temptable7') IS NOT NULL DROP TABLE #temptable7
IF object_id ('tempdb..#temptable8') IS NOT NULL DROP TABLE #temptable8
IF object_id ('tempdb..#temptable9') IS NOT NULL DROP TABLE #temptable9
IF object_id ('tempdb..#temptable10') IS NOT NULL DROP TABLE #temptable10
IF object_id ('tempdb..#temptable11') IS NOT NULL DROP TABLE #temptable11
-- Not an F5 just change those dates below for prev month
declare @start_date date declare @end_date date
SELECT
    '' AS 'share this with @medical' --here the person running the report puts the start & end dates of the reporting period
SET
    @start_date = '2023-05-01'
SET
    @end_date = '2023-05-31' --pull all visits
SELECT
    DISTINCT CONVERT(date, e.date) AS date,
    e.encounterid,
    p.pid,
    p.controlno,
    u.ufname,
    u.ulname,
    CONVERT(date, u.dob) AS dob,
    e.visittype,
    CASE
        WHEN e.visittype IN (
            'adult-fu',
            'adult-new',
            'adult-pe',
            'adult-urg',
            'deaf-fu',
            'deaf-new',
            'gyn-fu',
            'gyn-new',
            'gyn-urg',
            'MAT',
            'mat-audio',
            'med-audio',
            'med-tv',
            'ped-prenat',
            'peds-fu',
            'peds-pe',
            'peds-urg',
            'rcm-off'
        ) THEN 'medical'
        WHEN e.visittype LIKE 'den%' THEN 'dental'
        WHEN e.visittype LIKE 'bh%' THEN 'BH'
        WHEN e.visittype LIKE 'eye%' THEN 'vision'
        ELSE e.visittype
    END AS category,
    CASE
        WHEN e.facilityid = '12' THEN 1
        ELSE 0
    END AS SE,
    CASE
        WHEN e.facilityid <> '12' THEN 1
        ELSE 0
    END AS NW,
    d.printname AS doctor,
    e.status INTO #temptable1
FROM
    users u,
    patients p,
    doctors d,
    enc e
WHERE
    p.pid = u.uid
    AND p.pid = e.patientid
    AND d.doctorid = e.doct IF object_id ('tempdb..#temptable1') IS NOT NULL DROP TABLE #temptable1
    IF object_id ('tempdb..#temptable2') IS NOT NULL DROP TABLE #temptable2
    IF object_id ('tempdb..#temptable3') IS NOT NULL DROP TABLE #temptable3
    IF object_id ('tempdb..#temptable4') IS NOT NULL DROP TABLE #temptable4
    IF object_id ('tempdb..#temptable4a') IS NOT NULL DROP TABLE #temptable4a
    IF object_id ('tempdb..#temptable5') IS NOT NULL DROP TABLE #temptable5
    IF object_id ('tempdb..#temptable6') IS NOT NULL DROP TABLE #temptable6
    IF object_id ('tempdb..#temptable7') IS NOT NULL DROP TABLE #temptable7
    IF object_id ('tempdb..#temptable8') IS NOT NULL DROP TABLE #temptable8
    IF object_id ('tempdb..#temptable9') IS NOT NULL DROP TABLE #temptable9
    IF object_id ('tempdb..#temptable10') IS NOT NULL DROP TABLE #temptable10
    IF object_id ('tempdb..#temptable11') IS NOT NULL DROP TABLE #temptable11
    declare @start_date date declare @end_date date --here the person running the report puts the start & end dates of the reporting period
SET
    @start_date = '2023-04-01'
SET
    @end_date = '2023-04-30' --pull all visits
SELECT
    DISTINCT CONVERT(date, e.date) AS date,
    e.encounterid,
    p.pid,
    p.controlno,
    u.ufname,
    u.ulname,
    CONVERT(date, u.dob) AS dob,
    e.visittype,
    CASE
        WHEN e.visittype IN (
            'adult-fu',
            'adult-new',
            'adult-pe',
            'adult-urg',
            'deaf-fu',
            'deaf-new',
            'gyn-fu',
            'gyn-new',
            'gyn-urg',
            'MAT',
            'mat-audio',
            'med-audio',
            'med-tv',
            'ped-prenat',
            'peds-fu',
            'peds-pe',
            'peds-urg',
            'rcm-off'
        ) THEN 'medical'
        WHEN e.visittype LIKE 'den%' THEN 'dental'
        WHEN e.visittype LIKE 'bh%' THEN 'BH'
        WHEN e.visittype LIKE 'eye%' THEN 'vision'
        WHEN (
            e.visittype LIKE 'gps%'
            OR e.visittype LIKE 'SS-walk%'
        ) THEN 'care mgt'
        ELSE e.visittype
    END AS category,
    CASE
        WHEN e.facilityid = '12' THEN 1
        ELSE 0
    END AS SE,
    CASE
        WHEN e.facilityid <> '12' THEN 1
        ELSE 0
    END AS NW,
    d.printname AS doctor,
    e.status INTO #temptable1
FROM
    users u,
    patients p,
    doctors d,
    enc e
WHERE
    p.pid = u.uid
    AND p.pid = e.patientid
    AND d.doctorid = e.doctorid
    AND e.date BETWEEN @start_date
    AND @end_date
    AND e.status = 'CHK'
    AND (
        e.visittype IN (
            'adult-fu',
            'adult-new',
            'adult-pe',
            'adult-urg',
            'deaf-fu',
            'deaf-new',
            'gyn-fu',
            'gyn-new',
            'gyn-urg',
            'MAT',
            'mat-audio',
            'med-audio',
            'med-tv',
            'ped-prenat',
            'peds-fu',
            'peds-pe',
            'peds-urg',
            'rcm-off'
        )
        OR e.visittype LIKE 'BH%'
        OR e.visittype LIKE 'den%'
        OR e.visittype LIKE 'eye%'
        OR e.visittype LIKE 'gps%'
        OR e.visittype LIKE 'SS-Walk%'
    )
    AND u.ulname <> 'Test'
    AND e.deleteflag = '0'
SELECT
    @start_date AS StartDate,
    @end_date AS EndDate
SELECT
    concat (
        format(@end_date, 'MMMM'),
        ' visits by site and category'
    ) AS title
SELECT
    t1.Category,
    sum(t1.NW) AS NW,
    sum(t1.SE) AS SE,
    sum(t1.NW) + sum(t1.SE) AS Both_sites
FROM
    #temptable1 t1
GROUP BY
    t1.category
UNION
SELECT
    'zTotal',
    sum(t1.NW),
    sum(t1.SE),
    sum(t1.NW) + sum(t1.SE) AS Both_sites
FROM
    #temptable1 t1
ORDER BY
    t1.category --select * from #temptable1
    ----pull N/S visits
    --select distinct convert(date, e.date) as date, e.encounterid, p.pid, p.controlno, u.ufname, u.ulname, convert(date, u.dob) as dob, e.visittype
    --, case when e.visittype in ('adult-fu','adult-new','adult-pe','adult-urg', 
    --	'deaf-fu', 'deaf-new', 'gyn-fu','gyn-new','gyn-urg','MAT', 'mat-audio', 'med-audio', 'med-tv','ped-prenat'
    --		, 'peds-fu', 'peds-pe', 'peds-urg', 'rcm-off') then 'medical'
    --	when e.visittype like 'den%' then 'dental'
    --	when e.visittype like 'bh%' then 'BH'
    --	when e.visittype like 'eye%' then 'vision'
    --	else e.visittype end as category
    --,case when e.facilityid='12' then 1 else 0 end as SE
    --,case when e.facilityid<>'12' then 1 else 0 end as NW
    --,d.printname as doctor, e.status
    --into #temptable2
    --from users u, patients p, doctors d, enc e
    --where p.pid=u.uid
    --and p.pid=e.patientid
    --and d.doctorid=e.doctorid
    --and e.date between @start_date and @end_date
    --and e.status='N/S'
    --and (e.visittype in ('adult-fu','adult-new','adult-pe','adult-urg', 'deaf-fu', 'deaf-new'
    --, 'gyn-fu','gyn-new','gyn-urg','MAT', 'mat-audio', 'med-audio', 'med-tv','ped-prenat'
    --, 'peds-fu', 'peds-pe', 'peds-urg', 'rcm-off') 
    --	or e.visittype like 'BH%' or e.visittype like 'den%' or e.visittype like 'eye%')
    --and u.ulname<>'Test'
    --and e.deleteflag='0'
    --Select concat (format(@end_date,'MMMM'), ' *No Show* visits by site and category') as title
    --select t2.Category, sum(t2.NW) as NW, sum(t2.SE) as SE, sum(t2.NW)+sum(t2.SE) as Both_sites
    --from #temptable2 t2
    --group by t2.category
    --union
    --select 'zTotal', sum(t2.NW), sum(t2.SE), sum(t2.NW)+sum(t2.SE) as Both_sites
    --from #temptable2 t2orid
    /*
     and e.date between @start_date and @end_date
     and e.status='CHK'
     and (e.visittype in ('adult-fu','adult-new','adult-pe','adult-urg', 'deaf-fu', 'deaf-new'
     , 'gyn-fu','gyn-new','gyn-urg','MAT', 'mat-audio', 'med-audio', 'med-tv','ped-prenat'
     , 'peds-fu', 'peds-pe', 'peds-urg', 'rcm-off') 
     or e.visittype like 'BH%' or e.visittype like 'den%' or e.visittype like 'eye%')
     and u.ulname<>'Test'
     and e.deleteflag='0'
     
     Select @start_date as StartDate, @end_date as EndDate
     
     Select concat (format(@end_date,'MMMM'), ' visits by site and category') as title
     select t1.Category, sum(t1.NW) as NW, sum(t1.SE) as SE, sum(t1.NW)+sum(t1.SE) as Both_sites
     from #temptable1 t1
     group by t1.category
     union
     select 'zTotal', sum(t1.NW), sum(t1.SE), sum(t1.NW)+sum(t1.SE) as Both_sites
     from #temptable1 t1
     order by t1.category
     */