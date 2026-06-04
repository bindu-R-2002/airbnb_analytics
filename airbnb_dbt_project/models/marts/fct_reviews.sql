with reviews as (

    select
        listing_id,
        review_id,
        date,
        reviewer_id
    from {{ ref('stg_reviews') }}

),

listings as (

    select
        listing_id,
        host_id
    from {{ ref('dim_listings') }}

)

select
    r.review_id,
    r.listing_id,
    l.host_id,
    r.reviewer_id,
    r.date
from reviews r
left join listings l
    on r.listing_id = l.listing_id