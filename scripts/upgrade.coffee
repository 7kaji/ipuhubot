module.exports = (robot) ->
    github = require('githubot')(robot)
    unless (url_api_base = process.env.HUBOT_GITHUB_API)?
        url_api_base = "https://api.github.com"

    robot.respond /UPGRADE\sPREPARE$/i, (msg) ->
        github.get "#{url_api_base}/repos/sasarky/ipuhubot/compare/master...develop", (info) ->
            if (info.commits.length == 0)
                msg.send "進化素材が足りないよ"
            else
                cnt = 1
                for commit in info.commits 
                    if /^Merge pull request/.exec(commit.commit.message)?
                        continue
                    msg.send "[#{cnt}] #{commit.commit.message} (#{commit.commit.committer.name}): #{commit.html_url}"
                    cnt++
                msg.send "この進化素材で進化しちゃうよ？ ( https://github.com/sasarky/ipuhubot/compare/master...develop )"


    robot.respond /UPGRADE\sEXECUTE$/i, (msg) ->
        msg.send "ぶおおおおおおおおん"

        github.branches("sasarky/ipuhubot").merge "develop", (branches) ->
            msg.send("進化したよ！")
