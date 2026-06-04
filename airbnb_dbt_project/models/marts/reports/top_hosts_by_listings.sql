select
    host_id,
    name,
    count(*) as total_listings
from {{ ref('dim_hosts') }}
group by
    host_id,
    name
order by total_listings desc