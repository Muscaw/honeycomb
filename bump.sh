version="$1"

if ! [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Version does not match x.y.z" >&2
  exit 1
fi

# Verify we are currently at the top of the main branch

git fetch origin main
if [[ $(git rev-list --count HEAD..@{u}) != 0 ]]; then
  echo "Current git HEAD is not up-to-date with upstream" >&2
  exit 1
fi

uv version $version

git add pyproject.toml uv.lock

git commit -m "Bump project version to $version"
git tag $version

echo "Ready to push tag"
