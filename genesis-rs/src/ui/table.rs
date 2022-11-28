#[derive(Debug, Clone)]
pub struct TableView {
    style: Option<Style>,
}


#[derive(Debug, Clone)]
pub struct UITableViewCell {
    content_view: (),
    text_label: (),
    detail_text_label: (),
    background_view: (),
    selected_background_view: (),
    multiple_selection_background_view: (),
    selection_style: (),
    editing_style: (),
    shows_reorder_control: (),
    should_indent_while_editing: (),
    accessory_type: (),
    accessory_view: (),
    editing_accessory_type: (),
    editing_accessory_view: (),
    indentation_level: (),
    indentation_width: (),
    separator_inset: (),
    focus_style: (),
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub enum Style {
    Plain,
    Grouped,
    InsetGrouped,
}