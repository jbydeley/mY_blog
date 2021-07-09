import Config

config :my_blog, MyBlogWeb.Endpoint,
  http: [port: String.to_integer(System.get_env("HTTP_PORT"))],
  https: [port: String.to_integer(System.get_env("HTTPS_PORT"))]
