#![allow(unused)]
pub mod controllers;
pub mod ui;
pub mod data;
pub mod ux;
pub mod values;

use std::{any::Any, marker::PhantomData};
use ux_kit::c_ffi_utils::Pointer;

#[no_mangle]
pub extern "C" fn test_rust_function() {
    println!("Hello World - From Rust!");
}

pub struct AnyValue {
    value: Box<dyn Any>,
}

#[derive(Debug, Clone)]
pub enum SomeValue {
    String(String),
}

pub trait FFIOp {
    fn len(&self) -> Option<usize>;
    fn index_string(&self, index: usize) -> Option<String>;
}

impl FFIOp for GreekLetterList {
    fn len(&self) -> Option<usize> {
        Some(self.list.len())
    }
    fn index_string(&self, index: usize) -> Option<String> {
        self.list.get(index).map(Clone::clone)
    }
}


pub struct GreekLetterList {
    pub list: Vec<String>
}

impl GreekLetterList {
    pub fn new() -> Self {
        let list = vec![
            String::from("Alpha"),
            String::from("Beta"),
            String::from("Gamma"),
        ];
        GreekLetterList { list }
    }
}

#[no_mangle]
pub extern "C" fn rs_init_table_data() -> Pointer<GreekLetterList> {
    Pointer::new(GreekLetterList::new())
}





pub trait Viewable {
    fn tick(&mut self, upstream: Upstream, downstream: Downstream);
}

pub trait ViewController : Default + Reactable {
    fn view() -> &'static mut dyn Viewable;
}


pub trait Reactable {
    /// Initial state
    fn init(&mut self, upstream: Upstream, downstream: Downstream) -> (Upstream, Downstream) { (upstream, downstream) }
    /// Transformers
    fn downstream(&mut self, dataflow: Downstream) -> Downstream {dataflow}
    fn upstream(&mut self, dataflow: Upstream) -> Upstream {dataflow}
}





pub struct Downstream {}

pub struct Upstream {}




// #[derive(Debug, Clone)]
pub struct Label<T> {
    text_handle: PhantomData<T>,
}


#[derive(Debug, Clone)]
pub struct Signal<T> {
    stub: PhantomData<T>,
}

// impl Label {
//     pub fn new() {}
// }

// impl Viewable for Label {

// }


pub struct View<Msg> {
    stub: PhantomData<Msg>,
}


#[derive(Debug, Default)]
pub struct TodoComponent {
    
}

#[derive(Debug, Clone)]
pub enum TodoMsg {
    NoOp,
}

impl Default for TodoMsg {
    fn default() -> Self { TodoMsg::NoOp }
}

// impl ViewController for TodoComponent {
//     type Msg = TodoMsg;
//     type Model = GreekLetterList;
//     fn init() -> Self::Model {
//         GreekLetterList::new()
//     }
// }

pub fn dev() {
    let table_component = TodoComponent::default();
}





