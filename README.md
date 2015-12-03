# Provinces

Link coming soon!

## Minimum Viable Product

Build a province, create cities and become a power to be reckoned with.  Team up
with your friends to create powerful nations with sophisticated governance and
vie for global dominance through warfare and eminently affordable bonuses! :money_with_wings:

- [x] Create an account
- [x] Log in / Log out
- [x] Create, read, edit, and delete provinces and nations
- [x] Add avatars and flags
- [ ] Add cities and additional game logic
- [ ] Add messages and notifications
- [ ] Nation governance
- [ ] Add Store and Stripe
- [ ] War

## Design Docs
* [DB schema][schema]

[schema]: ./docs/schema.md

## Implementation Timeline
Note: Time estimates are full days of work, not calendar days

### Phase 1: User authentication, Province and Nation CRUD and MVC (2 days)

Basic user signup and signin, province and nation CRUD along with some basic
views and attributes.

[Details][phase-one]

### Phase 2: Add Images, and Settlements, flesh out game logic (2 days)

Add images for users to have avatars, provinces and nations to have flags and
possibly other images.  Add substantial game logic such as infrastructure,
technology, money, and provincial government types.  Add Settlements, allowing
users to found and grow settlements within their provinces for bonuses to
growth.

[Details][phase-two]

### Phase 3: Add Messages, Notifications, and national government (2 days)

Allow users to send messages to other users, their nation, or the whole
community.  Add notifications to inform users of messages or in-game events.
Add customizable roles to government.


[Details][phase-three]

### Phase 4: Add Stripe and store Items for microtransactions (3 days)

Allow users to buy small boosts for their provinces through an in-game store,
and collect their cold hard cash with Stripe.

[Details][phase-four]

### Phase 5: Add warfare, cleanup and seeding (2 days)

Nation-building is all well and good, but the only thing anyone really cares
about is tearing it all down.  Add warfare mechanic, and then tie up any loose
ends and create seed info.

Details: TBA


### Bonus Features (TBD)
- [ ] Province map (hexagon)
- [ ] Nation map (stick hexes together)
- [ ] Replace basic nation-wide messages with forums

[phase-one]: ./docs/phases/phase1.md
[phase-two]: ./docs/phases/phase2.md
[phase-three]: ./docs/phases/phase3.md
[phase-four]: ./docs/phases/phase4.md
