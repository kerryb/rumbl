defmodule Rumbl.VideoChannel do
  use Rumbl.Web, :channel

  def join "videos:" <> video_id, _params, socket do
    {:ok, assign(socket, :video_id, String.to_integer(video_id))}
  end

  def handle_in "new_annotation", params, socket do
    user = socket.assigns.current_user

    changeset = user
    |> build(:annotations, video_id: socket.assigns.video_id)
    |> Rumbl.Annotation.changeset(params)

    case Repo.insert changeset do
      {:ok, annotation} ->
        broadcast! socket, "new_annotation", %{
          user: Rumbl.UserView.render("user.json", %{user: user}),
          body: params["body"],
          at: params["at"]
        }
        {:reply, :ok, socket}
      {:error, changeset} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end
end
