with listings as (

    select *
    from {{ ref('stg_listings') }}

),

hosts as (

    select
        host_id,
        name,
        host_since,
        host_location,
        host_response_time,
        host_response_rate,
        host_acceptance_rate,
        host_is_superhost,
        host_total_listings_count,
        host_has_profile_pic,
        host_identity_verified
    from listings
    where host_id is not null

),

deduplicated as (

    select *
    from hosts
    qualify row_number() over (
        partition by host_id
        order by host_since desc nulls last
    ) = 1

)

select *
from deduplicated