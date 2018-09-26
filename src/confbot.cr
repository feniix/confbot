# TODO: Write documentation for `Confbot`
require "./confbot/config"
require "./confbot/confluence"

module ConfBot
  VERSION = "0.1.0"
  config = ConfBot::Config.new
  posts = ConfBot::Confluence.get_posts(config)

  index = Random.rand(posts["total_posts"].as_i) - 1
  puts posts["posts"][index]
end
