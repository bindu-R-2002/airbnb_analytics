with listings as (

    select
        listing_id,
        host_id,
        name,
        neighbourhood,
        room_type,
        price
    from {{ ref('dim_listings') }}

),

reviews as (

    select
        listing_id,
        review_id,
        date,
        reviewer_id,
    from {{ ref('fct_reviews') }}

),

review_summary as (

    select
        listing_id,
        count(review_id) as total_reviews,
        count(distinct reviewer_id) as unique_reviewers,
        min(date) as first_review_date,
        max(date) as latest_review_date
    from reviews
    group by listing_id

),

final as (

    select
        l.listing_id,
        l.host_id,
        l.name,
        l.neighbourhood,
        l.room_type,
        l.price,
        coalesce(rs.total_reviews, 0) as total_reviews,
        coalesce(rs.unique_reviewers, 0) as unique_reviewers,
        rs.first_review_date,
        rs.latest_review_date
    from listings l
    left join review_summary rs
        on l.listing_id = rs.listing_id

)

select *
from final