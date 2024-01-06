## Todo
- [x] Clean up index route
- [x] Check out TW styling on index route

## Later
- [ ] Try out Caddy server locally
- [ ] SSL on local Caddy?


## Recipe
- generate ecto migration
- fill in the migration file
- run the migration
- create the context module if needed
- create the schema module
- create the controller module
- creae the html view

**❯ mix phx.gen.live Samples Apple apples name:string origin:string**
* creating lib/blogsink_web/live/apple_live/show.ex
* creating lib/blogsink_web/live/apple_live/index.ex
* creating lib/blogsink_web/live/apple_live/form_component.ex
* creating lib/blogsink_web/live/apple_live/index.html.heex
* creating lib/blogsink_web/live/apple_live/show.html.heex
* creating test/blogsink_web/live/apple_live_test.exs
* creating lib/blogsink/samples/apple.ex
* creating priv/repo/migrations/20240106175651_create_apples.exs
* creating lib/blogsink/samples.ex
* injecting lib/blogsink/samples.ex
* creating test/blogsink/samples_test.exs
* injecting test/blogsink/samples_test.exs
* creating test/support/fixtures/samples_fixtures.ex
* injecting test/support/fixtures/samples_fixtures.ex

Add the live routes to your browser scope in lib/blogsink_web/router.ex:

    live "/apples", AppleLive.Index, :index
    live "/apples/new", AppleLive.Index, :new
    live "/apples/:id/edit", AppleLive.Index, :edit

    live "/apples/:id", AppleLive.Show, :show
    live "/apples/:id/show/edit", AppleLive.Show, :edit


Remember to update your repository by running migrations:

    $ mix ecto.migrate
