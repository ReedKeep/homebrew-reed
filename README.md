# ReedKeep/homebrew-reed

The Homebrew tap for [reed](https://github.com/ReedKeep/reed).

```sh
brew install ReedKeep/reed/reed
```

That's it — `brew` finds the tap from the name, so there's no separate `brew tap` step.

Upgrading is `brew upgrade reed`. If reed is already running as a service, restart it afterwards so the
daemon picks up the new binary:

```sh
reed down && reed up
```

> reed will tell you if you forget. A daemon whose binary changed underneath it says so and names that
> exact command, rather than leaving you to work out why `reed merge` stopped answering.

`Formula/reed.rb` is written by reed's release workflow, not by hand.
