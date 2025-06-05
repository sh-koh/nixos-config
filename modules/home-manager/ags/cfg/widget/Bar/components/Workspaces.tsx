import GLib from "gi://GLib"
import HyprlandWorkspaces from "./HyprlandWorkspaces"
import NiriWorkspaces from "./NiriWorkspaces"

export default function Workspaces(monitorID: number) {
  const current_desktop = GLib.getenv("XDG_CURRENT_DESKTOP")
  switch (current_desktop) {
    case "Hyprland": return HyprlandWorkspaces(monitorID);
    case "niri": return NiriWorkspaces(monitorID);
  }
}
