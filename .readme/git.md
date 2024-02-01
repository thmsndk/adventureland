# Prepering a PR from a feature branch

https://stackoverflow.com/questions/77535387/git-rebase-i-a-feature-branch

```
    o---o---o---o---o  master
        \
         o---o---o---o---o  next
                          \
                           o---o---o  topic
```

We want to make topic forked from branch master; for example, because the functionality on which topic depends was merged into the more stable master branch. We want our tree to look like this:

```
   o---o---o---o---o  master
       |            \
       |             o'--o'--o'  topic
        \
         o---o---o---o---o  next
```

We can get this using the following command:

```
git rebase --onto master next topic
```
