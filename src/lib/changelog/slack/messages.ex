defmodule Changelog.Slack.Messages do
  def welcome do
    ~s"""
    Welcome to Changelog's Community Slack team! :clap:

    This is an inclusive place where we chat about tech, life, our shows, or just whatever. *There are no imposters here*. By hanging out in this Slack, you are agreeing to abide by our Code of Conduct: https://changelog.com/coc

    You are welcome to join any channel. Each podcast has one (<#C3T5PE4G3|thechangelog>, <#C1YNE3WUX|jsparty>, <#C3T5RTLTV|gotime>, <#C1F3SRKL3|rfc>) and some are used for internal Changelog stuff (<#C03SA8VE2|dev>, <#C2HNEJ3J7|design>, <#C1DF0BHUM|podcasts>). Feel free to explore!

    When you get a moment, please introduce yourself in <#C024Q4CER|main>. Tell us where you're from, what you're up to, how you found this community, why you joined, and/or anything else about yourself you'd like us to know!

    Oh, and before you go... *here's our Slack color theme*

    #121921,#171f29,#61c192,#FFFFFF,#232f3f,#FFFFFF,#61c192,#61C192

    :green_heart:
    """
  end
end
