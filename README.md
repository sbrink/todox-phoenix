# ![todox-phoenix: Phoenix introductory workshop](https://raw.githubusercontent.com/visualitypl/todox-phoenix/master/todox-phoenix-logo.png)

Welcome to the Phoenix workshop! It covers typical aspects of web development in this amazing Elixir-based framework. The purpose is to demonstrate how easy it is to achieve in Phoenix things developed every day in Rails. It's done by quick-starting the example todo application.

You'll start with three mandatory exercises (A-C), followed by a bunch of extra exercises (E*) independent from each other, which you'll pick depending on your interests. Each exercise is covered with a thorough description and links with relevant information. There's a complete solution available in case of running into problems.

The solution code is based on Elixir 1.2, Phoenix 1.2 and Ecto 2.0 (the last is the most important as this version brings lots of model-related changes compared to Ecto 1.x).

## Prerequisites

### Install dependencies

There are following things you should have installed and ready for the workshop:

- [Node.js](https://nodejs.org/en/download/package-manager/) (it **must** be v4 or newer)
- [Elixir](http://elixir-lang.org/install.html) (it **must** be v1.2 or newer)
- [Phoenix](http://www.phoenixframework.org/docs/installation#section-phoenix) (it **must** be v1.2 or newer)
- [PostgreSQL](https://wiki.postgresql.org/wiki/Detailed_installation_guides)

### Prepare working directory

You should prepare the working directory as well:

1. Clone this repository.
2. `cd` into `solution/todox`.
3. Install dependencies with `mix deps.get`.
4. Compile the project with `mix compile`.

After doing that, you'll be able to start a new project in the `workspace` directory and proceed with the exercises there. And in case of problems, you'll always be able to take a look at and run the complete, compiled app in the `solution` directory.

### Get started with Elixir

You'll be using the Elixir language in this workshop. While it's not assumed that you're already familiar with it, you'll definitely proceed faster and learn more if you'll at least take a first look at the Elixir syntax. You can do so with the excellent [official Getting Started guide](http://elixir-lang.org/getting-started/introduction.html). It's recommended to read through sections 2-18 of the *Getting Started* on the right (from *Basic types* down to *Sigils*).

For those with more time, the *Programming Elixir* book is the ultimate resource for learning Elixir in detail.

## Exercises

Let's get started in the [previously prepared](#prepare-working-directory) `workspace` directory.

### A. Starting a new Phoenix project

Here's what to do in order to bootstrap the project and make it ready for our todo app development:

1. Create a new `todox` project.
2. Configure and create the development database.
3. Remove unneeded stock data (`phoenix.css`, stock Phoenix layout).

**Hints:** Take a look at [Up And Running](http://www.phoenixframework.org/docs/up-and-running) to learn how to start a new project. Look for the database configuration in `config` directory and templates in `web/templates` directory. You'll know that the database is configured correctly when `mix ecto.create` succeds. You'll find more about how to handle the database on the [Ecto Models](http://www.phoenixframework.org/docs/ecto-models) description page.

**Hints for Rails devs:** If you'd like to see how directory structure and Rake tasks from Rails project map to ones in Phoenix, read the [The best of Rails in Phoenix (part 1)](http://cloudless.pl/articles/2-the-best-of-rails-in-phoenix-part-1) .

After this step, you should have a working project that runs without errors via `mix phoenix.server` command and properly displays an empty home page in the browser at `localhost:4000`. You're now familiar with the Mix tool which serves as a single command for running all tasks in Elixir world.

### B. Implementing todo item management

Now, it's time to jump into actually coding in Elixir. You'll see how to implement all three MVC layers in Phoenix. Here's how to proceed in order to create a complete todo item resource in the app:

1. Add resource to router and link to item index from home page.
  - use the `resources` function in the router
  - controller should be named `TodoItemController`
2. Generate `TodoItem` model.
 - model should include the `content` and `done` fields
 - content should have a minimum length validated
3. Add controller with all actions except show
  - index action should order by id descending
  - index should show content and link to edit page
  - edit page should include the delete link
4. Add view and templates.
  - there should be templates for index, new and edit actions
  - form should be shared as partial used both in new and edit

**Hints:** Here's a bunch of related pages in the Phoenix documentation:

- [Adding Pages](http://www.phoenixframework.org/docs/adding-pages)
- [Routing](http://www.phoenixframework.org/docs/routing)
- [Ecto Models](http://www.phoenixframework.org/docs/ecto-models)
- [Controllers](http://www.phoenixframework.org/docs/controllers)
- [Views](http://www.phoenixframework.org/docs/views)
- [Templates](http://www.phoenixframework.org/docs/templates)

Also, there are tons of tutorials about creating CRUD in Phoenix, like [Getting Started With Phoenix: Building a Scaffolded CRUD App](http://nithinbekal.com/posts/elixir-phoenix-crud-app/) or [Phoenix "15 Minute Blog" comparison to Ruby on Rails](http://www.akitaonrails.com/2015/11/20/phoenix-15-minute-blog-comparison-to-ruby-on-rails).

After this step, you should be able to list, add, edit and delete todo items in the browser in a traditional fashion. You now know how to create a model and implement controller with accompanying views and templates. You can also use router and its view helpers, too.

### C. Adding some styles and dynamic behavior

Now, let's focus on the front-end a bit. But front-end can rarely work without proper back-end, so you'll also get to create a JSON API for AJAX purposes.

1. Use line-through to indicate done items.
2. Implement toggling todo items with AJAX.
  - install jQuery
  - implement the `toggle` action in TodoItemController that sets the `done` flag on given todo item
  - hook the new action into API pipeline in router to avoid the CSRF forgery check

**Hints:** You'll find the application CSS in `web/static/css`. When writing JS, you can use ES6 syntax, which by default is enabled in `web/static/js` in Phoenix. You can learn more about how assets work on [Static Assets](http://www.phoenixframework.org/docs/static-assets) page.

**Hints for Rails devs:** You can find a complete guide through differences between Rails Asset Pipeline and Phoenix asset solution in the [Rails asset pipeline vs Phoenix and Brunch](http://cloudless.pl/articles/9-rails-asset-pipeline-vs-phoenix-and-brunch) article. Among others, it shows how to install jQuery and how to use it in your `app.js`. Take a look at the solution code to see how to hook new route to API pipeline and how to render JSON with it.

## Extra exerciees

Here's a list of extra tasks for those willing to extend their knowledge about Phoenix. They're focusing on different aspects like the back-end, front-end, architecture or the console. Pick whatever you like the most.

**Note:** At present, only the solution to E6 is implemented in the solution code.

### E1. Use IEx for common database tasks

> Focus: **console** • Difficulty: **easy**

The task is to use IEx to create and example todo item, show it, update it and delete it. You can run IEx (the Elixir console) in the context of your project with:

```sh
iex -S mix
```

Here's a bunch of commands that you could try:

```elixir
# make our life easier
alias Todox.{Repo, TodoItem}
require Ecto.Query
import Ecto.Query

# query existing records
TodoItem |> Repo.all
TodoItem |> where(done: false) |> Repo.all
Repo.all from ti in TodoItem, where: ti.done == false, order_by: [ desc: ti.id ]

# create, update and delete records
%{ id: id } = TodoItem.changeset(%TodoItem{ content: "Item from console" }) |> Repo.insert!
TodoItem |> Repo.get!(id) |> TodoItem.changeset(%{ done: true }) |> Repo.update!
TodoItem |> Repo.get!(id) |> Repo.delete!
```

**Hints:** You can learn more about the fascinating Ecto query syntax in [Ecto.Query documentation](https://hexdocs.pm/ecto/Ecto.Query.html).

Using IEx, you'll be able to quickly act on your database. And with IEx's ability to plug into running production application, you'll be able to do that on production easier than ever.

### E2. Implement database seeds

> Focus: **console, back-end** • Difficulty: **medium**

The task is to add seed that creates example todos with fixed names belonging to sample users. In case of calling it multiple times, duplicate items or users shouldn't be created.

**Hints:** Look into `priv/repo/seeds.exs`.

As you can see, seeds are just plain scripts in Phoenix so nothing forbids you from writing as many as you want without having to invent new Rake tasks or whatever (as you would probably do in Rails). If you'd like to learn more about how Phoenix improves task running compared to Rails, read [Phoenix vs Rails: Mix and Rake tasks](http://cloudless.pl/articles/18-phoenix-vs-rails-mix-and-rake-tasks).

### E3. Use Slim for improved templating

> Focus: **front-end** • Difficulty: **easy**

The task is to enhance the template writing experience by using Slim-like syntax. The Elixir flavor of Slim is called [Slime](https://github.com/slime-lang/slime) and you can easily hook it into Phoenix with the [phoenix_slime](https://github.com/slime-lang/phoenix_slime) package. Here's what you should do:

1. Add the `phoenix_slime` package to the project.
2. Configure the Slime engine to be applied to `.slime` templates.
3. Convert application layout (`web/templates/layout/app.html.eex`) from EEx to Slime.

**Hints:** You can set the syntax highlighting in your editor for `*.slime` files to Slim if there's no dedicated Slime syntax definition available yet - it'll properly highlight in most cases due to Elixir's similarity to Ruby. Slime syntax is described on [Slime's home page](http://slime-lang.com).

### E4. Use Sass for extended styling

> Focus: **front-end** • Difficulty: **medium**

It's hard to imagine styling a complete project with plain CSS. So let's fix that:

1. Add `sass-brunch` to the project.
2. Apply basic styling to todo lists.
3. Try separating styles into multiple files and importing them.
4. Optionally, add PostCSS and Autoprefixer to support old browsers, too.

As Phoenix uses Brunch for assets, there's a variety of packages for making your work with CSS more pleasant, including [sass-brunch](https://www.npmjs.com/package/sass-brunch), [stylus-brunch](https://www.npmjs.com/package/stylus-brunch) or [postcss-brunch](https://www.npmjs.com/package/postcss-brunch). All of them will perfectly integrate with the Phoenix's hot CSS reloading too, so you should be able to configure a perfect front-end workspace for yourself.

### E5. Refactor the app with queries and commands

> Focus: **architecture, back-end** • Difficulty: **hard**

Every developer who has worked on large Rails project knows that model and controller layers are not enough alone for organizing the growing amount of business logic. That's why patterns like service/command objects, form objects and query objects emerged with gems like [rectify](https://github.com/andypike/rectify). The task is to mimic that in Phoenix:

1. Create command (service) modules for each action in todo item controller.
  - they should include authorization and repo calls
  - output should be either `{:ok, ...}` or `{:error, ...}`
  - output should be handled with the `case` directive
2. Create query module for the index.

**Hints for Rails devs:** Initially, Ecto included model callbacks, one of the Rails/ActiveRecord features that has heavily contributed to bloated models. That got fixed with Ecto v2, which you can learn more about in [Model callbacks in Phoenix, Ecto and Rails](http://cloudless.pl/articles/11-model-callbacks-in-phoenix-ecto-and-rails) article.

### E6. Implementing custom authentication

> Focus: **back-end, front-end** • Difficulty: **hard**

Phoenix flow is based on [Plug](http://www.phoenixframework.org/docs/understanding-plug). With it, it's easy to implement middleware and filters needed for features such as authentication. This exercise is about implementing a completely working and secure user auth with it.

1. Create the `User` model.
  - model should include the `username` and `password_hash` fields
  - username should be guaranteed to be unique on the database level
  - both username and password should have a minimum length validated on registration
2. Implement `RegistrationController` with `new` and `create` actions.
  - declare the routes with `resources` using `singular` option
  - use the Comeonin package for hashing and authenticating passwords
3. Implement `SessionController` with `new`, `create` and `delete` actions.
4. Add plug for loading user from session.
  - logged in user should be assigned as `current_user` conn assign
5. Add links in layout for registering, logging in and logging out.

**Hints:** There's an excellent section in the *Programming Phoenix* book about implementing user authentication (which the solution code is based on). There are also many tutorials, for example: [User Authentication from Scratch in Elixir and Phoenix](http://nithinbekal.com/posts/phoenix-authentication/). You can take a look at the solution code, too. You should be already able to create an user model and relevant controllers and views. The only tricky part is the auth plug implemented in `web/controllers/auth.ex` in solution repo.

**Follow up:** Having complete authentication, you can now rework the todo items resource to work with users, like this:

1. Update todo items to belong to users.
2. Modify the controller and templates to only allow item author to update or delete it.
3. Display the author of each item on the index page.

You'll find a solution code for this exercise on the [custom-auth](https://github.com/visualitypl/todox-phoenix/tree/custom-auth) branch.
