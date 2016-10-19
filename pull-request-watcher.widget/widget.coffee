# Display the PRs that USER has opened on GitHub that are still opened
# on a given REPO.
#
# Parameters:
#   - GITHUB_AUTH_TOKEN: GitHub 'Personal access token' with 'repo' scope
#   - REPO: Name of the GitHub repository that will be watched
#   - USER: The GitHub user that has opened the PullRequest
#
# Caveats:
#   - this widget relies on 'jq' which can be installed with
#     `brew install jq`
#   - GitHub access token can be created at
#     Settings > Developer Settings > Personal access token


# this is the shell command that gets executed every time this widget refreshes
GITHUB_AUTH_TOKEN = ''
REPO = ''
ORGANIZATION = ''
USER = ''
command: "curl -s -H \"Authorization: token #{GITHUB_AUTH_TOKEN}\" " +
         "https://api.github.com/repos/#{REPO}/pulls | " +
         "/usr/local/bin/jq 'map(select((.user.login==\"#{USER}\") " +
         "and (.state==\"open\")) | {title: .title, number: .number})'"
# the refresh frequency in milliseconds
refreshFrequency: 5000

render: (output) ->
  html = ""
  for item in JSON.parse(output)
    html += "<p>" + item["title"] + "</p>"
  html

style: """
  background: rgba(#fff, 0.95)
  background-size: 176px 84px
  -webkit-backdrop-filter: blur(20px)
  border-radius: 1px
  border: 2px solid #fff
  box-sizing: border-box
  color: #141f33
  font-family: Helvetica Neue
  font-weight: 300
  left: 50%
  line-height: 1.5
  margin-left: -625px
  padding: 20px 20px 20px 20px
  top: 10%
  width: auto
  text-align: justify

  h1
    font-size: 20px
    font-weight: 300
    margin: 16px 0 8px

  em
    font-weight: 400
    font-style: normal
"""
