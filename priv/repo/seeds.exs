alias Rumbl.Repo
alias Rumbl.Category

for category <- ~w(Action Drame Comedy Romance Sci-Fi) do
  Repo.get_by Category, name: category || Repo.insert! %Category{name: category}
end
