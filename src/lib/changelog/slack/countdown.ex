defmodule Changelog.Slack.Countdown do
  alias Timex.Duration
  alias Changelog.Wavestreamer

  def live(nil) do
    respond("There aren't any upcoming live recordings scheduled :sob:")
  end

  def live(next_episode) do
    diff = Timex.diff(next_episode.recorded_at, Timex.now, :duration)
    formatted = Timex.format_duration(diff, :humanized)
    podcast = next_episode.podcast.name
    title = next_episode.title

    respond(case Duration.to_hours(diff) do
      h when h <= 0 ->
        if Wavestreamer.is_streaming() do
          "#{live_message(podcast)}! Listen ~> https://changelog.com/live :tada:"
        else
          "#{podcast} _should_ be live, but the stream isn't up yet :thinking_face:"
        end
      h when h < 2  -> "There's just *#{formatted}* until #{podcast} (#{title}) :eyes:"
      h when h < 24 -> "There's only *#{formatted}* until #{podcast} (#{title}) :sweat_smile:"
      _else -> "There's still *#{formatted}* until #{podcast} (#{title}) :pensive:"
    end)
  end

  defp respond(text) do
    %Changelog.Slack.Response{text: text}
  end

  defp live_message("Go Time"), do: "It's Go Time"
  defp live_message("JS Party"), do: "JS Party Time, y'all"
  defp live_message(name), do: "#{name} is recording live"
end
