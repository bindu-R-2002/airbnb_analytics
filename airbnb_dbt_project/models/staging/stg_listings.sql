select
    try_to_number(listing_id)::integer as listing_id,

    name::varchar as name,

    host_id::varchar as host_id,
    try_to_date(host_since) as host_since,

    host_location::varchar as host_location,
    host_response_time::varchar as host_response_time,

    host_response_rate::varchar as host_response_rate,
    host_acceptance_rate::varchar as host_acceptance_rate,

    host_is_superhost::varchar as host_is_superhost,

    try_to_number(host_total_listings_count)::integer as host_total_listings_count,

    host_has_profile_pic::varchar as host_has_profile_pic,
    host_identity_verified::varchar as host_identity_verified,

    neighbourhood::varchar as neighbourhood,
    district::varchar as district,
    city::varchar as city,

    try_to_double(latitude) as latitude,
    try_to_double(longitude) as longitude,

    property_type::varchar as property_type,
    room_type::varchar as room_type,

    try_to_number(accommodates)::integer as accommodates,
    try_to_double(bedrooms) as bedrooms,

    amenities::varchar as amenities,

    try_to_decimal(replace(replace(price, '$', ''), ',', ''), 10, 2) as price,

    try_to_number(minimum_nights)::integer as minimum_nights,
    try_to_number(maximum_nights)::integer as maximum_nights,

    try_to_double(review_scores_rating) as review_scores_rating,
    try_to_double(review_scores_accuracy) as review_scores_accuracy,
    try_to_double(review_scores_cleanliness) as review_scores_cleanliness,
    try_to_double(review_scores_checkin) as review_scores_checkin,
    try_to_double(review_scores_communication) as review_scores_communication,
    try_to_double(review_scores_location) as review_scores_location,
    try_to_double(review_scores_value) as review_scores_value,

    instant_bookable::varchar as instant_bookable

from {{ source('airbnb', 'LISTINGS') }}