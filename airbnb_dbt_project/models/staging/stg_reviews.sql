select
    *
from {{ source('airbnb', 'REVIEWS') }}