---
name: default-branch-sync
description: >
  現在のブランチをそのリポジトリのデフォルトブランチ（origin/HEAD）と同期するとき必ず使うこと。
  「デフォルトブランチと同期したい」「最新を取り込みたい」「main / development を取り込みたい」
  「ブランチを最新化したい」などの発言があれば即座にこのSkillを使うこと。
  どのリポジトリ・どのブランチ・どのワークツリーでも使える汎用スキル。
allowed-tools: [Read, Bash(git *), AskUserQuestion]
---

# default-branch-sync

## 概要

**カレントディレクトリの git リポジトリ**で、現在チェックアウトしているブランチに
**デフォルトブランチ（`origin/HEAD` が指すブランチ）の最新コミットを取り込む**汎用スキル。

デフォルトブランチ名（`main` / `master` / `development` など）はリポジトリごとに異なるため、
**ハードコードせず必ず動的検出する**。特定のリポジトリ名・ブランチ名を前提にしない。

原則:

- **独自コミットが無い（ahead=0）なら fast-forward で取り込む** — 履歴を汚さず最も安全。
- **独自コミットがある（ahead>0）場合は必ずユーザーに merge / rebase / スキップを確認する** — 勝手に履歴を書き換えない。
- 未コミット変更は stash で退避し、同期後に必ず戻す。

---

## Step 1: リポジトリとデフォルトブランチの確認

カレントディレクトリが git リポジトリ（ワークツリー含む）か確認する。

```bash
git rev-parse --is-inside-work-tree
```

現在のブランチとデフォルトブランチを取得する。

```bash
# 現在のブランチ
git rev-parse --abbrev-ref HEAD

# デフォルトブランチ（origin/HEAD が指す先）
git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null | sed 's@^origin/@@'
```

`origin/HEAD` が未設定で空が返る場合は、リモートから取得し直してから再度読む:

```bash
git remote set-head origin --auto >/dev/null 2>&1
git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null | sed 's@^origin/@@'
```

それでも取得できない場合のみ、`origin/main` → `origin/master` → `origin/development` の順で
存在するものを候補として提示し、**どれをデフォルトブランチとして扱うかユーザーに確認する**
（勝手に決めない）。

現在のブランチがデフォルトブランチそのものだった場合は、
「今デフォルトブランチ上にいるので取り込み元がありません（`git pull` で十分です）」と伝えて終了。

---

## Step 2: 最新を取得して差分を確認

```bash
git fetch origin
```

現在のブランチ（`HEAD`）とデフォルトブランチ（以降 `<default>` と表記）の
ahead / behind を測る:

```bash
# 出力は "behind<TAB>ahead"
git rev-list --left-right --count "origin/<default>...HEAD"
```

結果をユーザーへ提示する:

- **behind=0 かつ ahead=0** → 「すでに最新です」と伝えて終了。
- **behind=0 かつ ahead>0** → デフォルトブランチ側に新しいコミットは無い（自分が先行しているだけ）。
  取り込むものが無い旨を伝えて終了。
- **behind>0 かつ ahead=0** → **Step 3A**（fast-forward）へ。
- **behind>0 かつ ahead>0** → **Step 3B**（分岐あり・ユーザー確認）へ。

---

## Step 3 の前提: 未コミット変更の退避

作業ツリーに未コミット変更（modified / staged / コミット対象になりうる untracked）があるか確認する。

```bash
git status --porcelain
```

変更がある場合は stash に退避し、退避したことを覚えておく（後で必ず戻す）:

```bash
git stash push -u -m "WIP: pre default-branch-sync"
```

変更が無ければこの退避はスキップする。

---

## Step 3A: fast-forward で取り込む（ahead=0 の場合）

独自コミットが無いので、履歴を作らず fast-forward で取り込む:

```bash
git merge --ff-only "origin/<default>"
```

`--ff-only` が失敗した場合は、想定外に分岐している可能性があるため
**そこで止めてユーザーへ状況を報告する**（強制はしない）。成功したら Step 4 へ。

---

## Step 3B: 分岐あり — ユーザーに方針を確認する（ahead>0 の場合）

現在のブランチにデフォルトブランチへ入っていない独自コミットがある。
**勝手に merge / rebase を選ばず、AskUserQuestion で必ず確認する。**

参考情報として独自コミットを提示するとよい:

```bash
git log --oneline "origin/<default>..HEAD"
```

選択肢:

1. **merge で取り込む** — `git merge origin/<default>`。独自コミットは保持。マージコミットが1つ増える。
   push 済みブランチでも安全。
2. **rebase で載せ替える** — `git rebase origin/<default>`。履歴は線形になるが、
   push 済みの場合は **force push（`git push --force-with-lease`）が必要**なことを明示する。
3. **今回はスキップ** — 何もせず終了。

選ばれた操作を実行する。**コンフリクトが発生した場合は自動解決せず、
どのファイルが衝突したかをユーザーへ提示して解消方針を確認する。**

- merge 中の続行: `GIT_EDITOR=true git merge --continue`
  （`--no-edit` は `git merge --continue` では無効。エディタを開かせないため `GIT_EDITOR=true` を使う）
- rebase 中の続行: `git rebase --continue` / 中止: `git rebase --abort`

---

## Step 4: stash を戻す

Step 3 前提で stash した場合のみ実行する。

```bash
git stash pop
```

`git stash pop` でコンフリクトが発生した場合は自動解決せず、内容をユーザーへ提示して手動解消を依頼する。

---

## Step 5: 結果の報告（push は勝手にしない）

同期後の状態を確認して報告する:

```bash
git log --oneline -5
git status --short
```

- fast-forward / merge の場合、ローカルは進んでいる。**push が必要かはユーザーの判断**なので、
  勝手に `git push` せず「push しますか？」と確認する。
- rebase を行い、かつ元ブランチが push 済みだった場合は、
  `git push --force-with-lease` が必要な旨を伝え、実行するかを確認する。

---

## 注意事項

- デフォルトブランチ名は**リポジトリごとに異なる**。必ず `origin/HEAD` から動的検出し、
  取れないときだけユーザーに確認する。`development` 等を決め打ちしない。
- **ahead>0 の分岐時に無断で rebase / force push をしない。** 履歴の書き換えは必ずユーザー確認を経る。
- stash した内容は必ず pop して元の状態に戻す。
- push は常にユーザー確認を経てから行う（このスキルは同期までを責務とする）。
  `rails-upgrade-dev-sync` の管轄。混同しない。
- 複数のワークツリー／リポジトリをまとめて同期したい場合は、対象ディレクトリごとに
  本スキルの手順を繰り返す（`git -C <dir> ...` でも同様に動く）。
