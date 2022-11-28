#[derive(Debug, Clone)]
pub struct View {
    is_user_interaction_enabled: Option<bool>,
    can_become_focused: Option<bool>,
}