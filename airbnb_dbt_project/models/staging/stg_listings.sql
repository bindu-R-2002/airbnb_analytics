select
    listing_id::integer as listing_id,
    coalesce(nullif(trim(name), ''), 'Unknown') as name,

    host_id::integer as host_id,
    host_since::date as host_since,
    nullif(trim(host_location), '') as host_location,
    nullif(trim(host_response_time), '') as host_response_time,

    replace(host_response_rate, '%', '')::float / 100 as host_response_rate,
    replace(host_acceptance_rate, '%', '')::float / 100 as host_acceptance_rate,

    case
        when host_is_superhost = 't' then true
        when host_is_superhost = 'f' then false
        else null
    end as host_is_superhost,

    host_total_listings_count::integer as host_total_listings_count,

    case
        when host_has_profile_pic = 't' then true
        when host_has_profile_pic = 'f' then false
        else null
    end as host_has_profile_pic,

    case
        when host_identity_verified = 't' then true
        when host_identity_verified = 'f' then false
        else null
    end as host_identity_verified,

    nullif(trim(neighbourhood), '') as neighbourhood,
    nullif(trim(district), '') as district,
    nullif(trim(city), '') as city,

    latitude::float as latitude,
    longitude::float as longitude,

    nullif(trim(property_type), '') as property_type,
    nullif(trim(room_type), '') as room_type,

    accommodates::integer as accommodates,
    bedrooms::float as bedrooms,

    amenities,

    replace(replace(price, '$', ''), ',', '')::numeric(10,2) as price,

    minimum_nights::integer as minimum_nights,
    maximum_nights::integer as maximum_nights,

    review_scores_rating::float as review_scores_rating,
    review_scores_accuracy::float as review_scores_accuracy,
    review_scores_cleanliness::float as review_scores_cleanliness,
    review_scores_checkin::float as review_scores_checkin,
    review_scores_communication::float as review_scores_communication,
    review_scores_location::float as review_scores_location,
    review_scores_value::float as review_scores_value,

    case
        when instant_bookable = 't' then true
        when instant_bookable = 'f' then false
        else null
    end as instant_bookable

from {{ source('airbnb', 'LISTINGS') }}