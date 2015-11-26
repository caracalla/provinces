# Schema Information

## users
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
email           | string    | not null, indexed, unique
password_digest | string    | not null
username        | string    | not null, unique
session_token   | string    | not null, indexed, unique
admin           | boolean   | not null, default: false

## provinces
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
user_id         | integer   | not null, foreign key (refs users), indexed
name            | string    | not null, unique
user_title      | string    | not null
population      | integer   | not null, default: 0
infrastructure  | integer   | not null, default: 0
technology      | integer   | not null, default: 0
money           | integer   | not null, default: 0
currency_name   | string    | not null
government_type | string    | not null
local_tax_rate  | integer   | not null, default: 15
resource_1      | string    | not null
resource_2      | string    | not null
description     | text      |

## nations
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
name            | string    | not null, unique
description     | text      |

## settlements
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
province_id     | integer   | not null, foreign key (refs provinces), indexed
name            | string    | not null
population      | integer   | not null, default: 0

## national membership
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
province_id     | integer   | not null, foreign key (refs provinces), indexed
nation_id       | integer   | not null, foreign key (refs nations), indexed
rank            | integer   | not null, default: 0
member_title    | string    | not null, default: "Member"

## images
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
imageable_id    | integer   | not null, polymorphic
imageable_type  | string    | not null, polymorphic
url             | string    | not null
primary         | boolean   | not null, default: false

## messages
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
sender_id       | integer   | not null, foreign key (refs users), indexed
recipient_id    | integer   | not null, polymorphic
recipient_type  | integer   | not null, polymorphic
state           | string    | not null, default: "unread"
money           | integer   | not null, default: 0
content         | text      | not null

## notifications
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
user_id         | integer   | not null, foreign_key (refs users), indexed
type            | string    | not null
content         | string    | not null
state           | string    | not null, default: "unseen"

## store_items
column name     | data type | details
----------------|-----------|-----------------------
id              | integer   | not null, primary key
price           | integer   | not null, default: 0
money_boost     | integer   | not null, default: 0
infrastructure  | integer   | not null, default: 0
technology      | integer   | not null, default: 0
