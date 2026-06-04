with listing_reviews as (

    select
        listing_id,
        room_type,
        price,
        total_reviews,
        unique_reviewers
    from {{ ref('listing_review_summary') }}

),

final as (

    select
        room_type,

        count(listing_id) as total_listings,

        avg(price) as avg_price,
        min(price) as min_price,
        max(price) as max_price,

        sum(total_reviews) as total_reviews,
        avg(total_reviews) as avg_reviews_per_listing,

        sum(unique_reviewers) as total_unique_reviewers

    from listing_reviews
    where room_type is not null
    group by room_type

)

select *
from final