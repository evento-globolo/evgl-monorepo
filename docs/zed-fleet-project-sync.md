# Zed fleet and project synchronization

Status date: 2026-08-05

This document is the durable cross-system status record for the canonical `evento-globolo` source fleet. It keeps GitHub repositories, GitHub Project #1, and the Linear project `github.com/evento-globolo` aligned without creating a second package namespace.

## Canonical package graph

| Consumer | Required Zed dependencies |
| --- | --- |
| `evgl-clients` | `evento-globolo/evgl-interfaces` |
| `evgl-libs` | `evento-globolo/evgl-interfaces` |
| `evgl-sync` | `evento-globolo/evgl-interfaces` |
| `evgl-cli` | `evgl-clients`, `evgl-interfaces`, `evgl-libs` |
| API and web servers | `evgl-interfaces`, `evgl-libs`, `evgl-sync`, `shared-auth/shared-auth-clients` |
| `evgl-monorepo` | clients, interfaces, libs, CLI, sync, and shared-auth clients |
| planned `evgl-mcp-server.rs` | clients, interfaces, libs, CLI, sync, and shared-auth clients |
| planned `evgl-e2e` | clients, interfaces, libs, and CLI |

Dependencies materialize under `.vendor/.zed`. Generated dependency trees are not committed or published. `.zpkg.lock` is generated only by a real successful resolver run; it is never fabricated from repository metadata.

## Completed delivery

- `evgl-monorepo#4` completed the canonical short-name dependency graph.
- `evgl-sync#3` added the missing Zed package identity and canonical interfaces dependency.
- API, Mash, Leptos, and Dioxus packages consume interfaces, libs, sync, and shared-auth clients.
- `evgl-cli` consumes clients, interfaces, and libs.
- Long-name repositories are compatibility history only. New package coordinates, issues, pull requests, releases, and submodule adoption use `evgl-*`.

## Validation fleet

The separate `evento-globolo-test` organization already exercises Mash, Leptos, Dioxus, Flutter web, API, WebSocket updates, ticket/check-in, recurrence/timezone, search, payments/webhooks, organizer permissions, offline sync, load, infrastructure, and CLI contracts. The planned product-level `evgl-e2e` repository consolidates cross-product smoke contracts without replacing that specialized validation fleet.

## Remaining repositories

| Repository | GitHub tracker | Linear tracker |
| --- | --- | --- |
| `evento-globolo/evgl-mcp-server.rs` | `evgl-monorepo#2` | `DEN-2290` |
| `evento-globolo/evgl-e2e` | `evgl-monorepo#7` | `DEN-2291` |

Both repositories are blocked only on organization-level repository creation. Once created, the connected GitHub write path can create branches and files, push commits, open pull requests, inspect checks, and merge.

## Git and Zed ownership rule

Git submodules remain valid exact-source transport, but the same repository must not be represented twice in one composition. Intentional Zed adoption uses `zed overtake --git-submodules`: Git retains the committed gitlink and source checkout, while Zed owns package identity, dependency intent, materialization, and immutable lock provenance. Non-Zed submodules remain solely Git-managed.

Every committed gitlink must be classified in `.zed-submodules.tsv`. CI rejects unclassified gitlinks, long-name duplicate coordinates, committed `.vendor/.zed` or `zed_modules` content, and any repository used simultaneously as a Zed dependency and a submodule.

## Planning authorities

- GitHub organization: `evento-globolo`
- GitHub Project: organization Project #1
- Linear project: `github.com/evento-globolo`
- Parent fleet issue: `DEN-1889`
- Repository-creation capability issue: `DEN-319`

GitHub issues and implementation pull requests must link the matching Linear issue and organization Project. Status is updated in both systems when a repository is created, a PR is merged, or a dependency/lock gate changes.