defmodule BlogsinkWeb.Router do
  use BlogsinkWeb, :router
  import PhoenixStorybook.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {BlogsinkWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    storybook_assets()
  end

  scope "/", Elixir.BlogsinkWeb do
    pipe_through(:browser)
    live_storybook "/storybook", backend_module: Elixir.BlogsinkWeb.Storybook
  end

  scope "/", BlogsinkWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/apples", AppleLive.Index, :index
    live "/apples/new", AppleLive.Index, :new
    live "/apples/:id/edit", AppleLive.Index, :edit

    live "/apples/:id", AppleLive.Show, :show
    live "/apples/:id/show/edit", AppleLive.Show, :edit

    resources "/students", StudentController

  end

  # Other scopes may use custom stacks.
  # scope "/api", BlogsinkWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:blogsink, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: BlogsinkWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
