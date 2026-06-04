with reviews as (

    select
        review_id,
        listing_id,
        reviewer_id,
        date
    from {{ ref('fct_reviews') }}

),

final as (

    select
        date_trunc('month', date) as review_month,

        count(review_id) as total_reviews,
        count(distinct listing_id) as reviewed_listings,
        count(distinct reviewer_id) as unique_reviewers

    from reviews
    where date is not null
    group by 1

)

select *
from final