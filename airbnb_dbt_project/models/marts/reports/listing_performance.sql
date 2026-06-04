select
    l.listing_id,
    l.name,
    l.room_type,
    l.price,
    count(r.review_id) as total_reviews
from {{ ref('stg_listings') }} l
left join {{ ref('fct_reviews') }} r
    on l.listing_id = r.listing_id
group by
    l.listing_id,
    l.name,
    l.room_type,
    l.price