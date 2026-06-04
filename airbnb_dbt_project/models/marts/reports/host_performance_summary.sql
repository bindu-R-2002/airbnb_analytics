with listing_reviews as (

    select
        listing_id,
        host_id,
        name,
        neighbourhood,
        room_type,
        price,
        total_reviews,
        unique_reviewers
    from {{ ref('listing_review_summary') }}

),

hosts as (

    select
        host_id,
        name
    from {{ ref('dim_hosts') }}

),

host_summary as (

    select
        host_id,

        count(listing_id) as total_listings,
        count(distinct neighbourhood) as total_neighbourhoods,
        count(distinct room_type) as total_room_types,

        avg(price) as avg_listing_price,
        min(price) as min_listing_price,
        max(price) as max_listing_price,

        sum(total_reviews) as total_reviews,
        avg(total_reviews) as avg_reviews_per_listing,
        sum(unique_reviewers) as total_unique_reviewers

    from listing_reviews
    group by host_id

),

final as (

    select
        hs.host_id,
        h.name,

        hs.total_listings,
        hs.total_neighbourhoods,
        hs.total_room_types,

        hs.avg_listing_price,
        hs.min_listing_price,
        hs.max_listing_price,

        hs.total_reviews,
        hs.avg_reviews_per_listing,
        hs.total_unique_reviewers

    from host_summary hs
    left join hosts h
        on hs.host_id = h.host_id

)

select *
from final