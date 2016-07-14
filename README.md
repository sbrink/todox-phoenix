# todox-phoenix

Welcome to the Phoenix workshop! It covers typical aspects of web development in this amazing Elixir-based framework. The purpose is to demonstrate how easy it is to achieve in Phoenix things developed every day in Rails (or other framework as there are no direct references to Rails). It's done by quick-starting the example todo application.

You'll start with three mandatory exercises (A-C), followed by a bunch of extra exercises (E*) independent from each other, which you'll pick depending on your interests. Each exercise is covered with a thorough description and links with relevant information. There's a complete solution available in case of running into problems.

The solution code is based on Elixir 1.2, Phoenix 1.2 and Ecto 2.0 (it's important as this version brings many changes compared to Ecto 1.x).

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

You should take a look at [Up And Running](http://www.phoenixframework.org/docs/up-and-running) to learn how to start a new project. You'll find the database configuration in `config` directory and templates in `web/templates` directory. You'll find more about how to handle the database on the [Ecto Models](http://www.phoenixframework.org/docs/ecto-models) description page.

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

Here's a bunch of related pages in the Phoenix documentation:

- [Adding Pages](http://www.phoenixframework.org/docs/adding-pages)
- [Routing](http://www.phoenixframework.org/docs/routing)
- [Ecto Models](http://www.phoenixframework.org/docs/ecto-models)
- [Controllers](http://www.phoenixframework.org/docs/controllers)
- [Views](http://www.phoenixframework.org/docs/views)
- [Templates](http://www.phoenixframework.org/docs/templates)

After this step, you should be able to list, add, edit and delete todo items in the browser in a traditional fashion. You now know how to create a model and implement controller with accompanying views and templates. You can also use router and its view helpers, too.

### C. Adding some styles and dynamic behavior

Now, let's focus on the front-end a bit. But front-end can rarely work without proper back-end, so you'll also see how to create the API for AJAX purposes.

1. Use line-through to indicate done items.
2. Implement toggling todo items with AJAX.
  - install jQuery via NPM
  - use ES6 syntax already enabled in Phoenix
  - hook the new action (added in TodoItemController) into API pipeline in router

You'll find the application CSS in `web/static/css`. You can learn more about how assets work on [Static Assets](http://www.phoenixframework.org/docs/static-assets) page.

### E. Extra exerciees

Here's a list of extra tasks for those willing to extend their knowledge about Phoenix. They're focusing on different aspects like the back-end, front-end, architecture or the console. Pick whatever you like the most.

#### E1. Use IEx for common database tasks

> Focus: **console** • Difficulty: **easy**

1. Use IEx to create and example todo item, show it, update it and delete it.

#### E2. Implement database seeds

> Focus: **console, back-end** • Difficulty: **medium**

1. Add seed that creates example todos with fixed names belonging to sample users.
 - in case of calling it multiple times, duplicate items or users shouldn't be created

#### E3. Use Slim for improved templating

> Focus: **front-end** • Difficulty: **easy**

1. Add the phoenix_slime package to the project.
2. Configure the Slime engine to be applied to `.slime` templates.
3. Convert application layout from EEx to Slime (`templates/layout/app.html.eex`).

#### E4. Use Sass for extended styling

> Focus: **front-end** • Difficulty: **medium**

1. Add the sass-brunch dependency to the project.
2. Apply basic styling to todo lists.
3. Try separating styles into multiple files and importing them.

#### E5. Refactor the app with queries and commands

> Focus: **architecture, back-end** • Difficulty: **hard**

1. Create command (service) modules for each action in todo item controller.
  - they should include authorization and repo calls
  - output should be either `{:ok, ...}` or `{:error, ...}`
  - output should be handled with the `case` directive
2. Create query module for the index.

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

There's an excellent section in the Programming Phoenix book about implementing user authentication. There are also many tutorials, for example: [User Authentication from Scratch in Elixir and Phoenix](http://nithinbekal.com/posts/phoenix-authentication/). You can take a look at the solution code, too. You should be already able to create an user model and relevant controllers and views. The only tricky part is the auth plug implemented in `web/controllers/auth.ex` in solution repo.

Having complete authentication, you can now rework the todo items resource to work with users, like this:

1. Update todo items to belong to users.
2. Modify the controller and templates to only allow item author to update or delete it.
3. Display the author of each item on the index page.
