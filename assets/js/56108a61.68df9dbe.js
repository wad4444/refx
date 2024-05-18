"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[371],{1528:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>c,contentTitle:()=>s,default:()=>m,frontMatter:()=>i,metadata:()=>l,toc:()=>d});var r=n(4848),a=n(8453),o=n(1470),u=n(9365);const i={sidebar_position:6},s="Configuration",l={id:"tutorial/guide/configuration",title:"Configuration",description:"You can configure your custom methods by using built-in function called Configure.",source:"@site/docs/tutorial/guide/configuration.md",sourceDirName:"tutorial/guide",slug:"/tutorial/guide/configuration",permalink:"/refx/docs/tutorial/guide/configuration",draft:!1,unlisted:!1,tags:[],version:"current",sidebarPosition:6,frontMatter:{sidebar_position:6},sidebar:"tutorialSidebar",previous:{title:"Invoking Methods",permalink:"/refx/docs/tutorial/guide/invoking-methods"},next:{title:"Manual Destruction",permalink:"/refx/docs/tutorial/guide/manual-destruction"}},c={},d=[];function f(e){const t={code:"code",em:"em",h1:"h1",p:"p",pre:"pre",...(0,a.R)(),...e.components};return(0,r.jsxs)(r.Fragment,{children:[(0,r.jsx)(t.h1,{id:"configuration",children:"Configuration"}),"\n","\n",(0,r.jsxs)(t.p,{children:["You can ",(0,r.jsx)(t.em,{children:"configure"})," your ",(0,r.jsx)(t.em,{children:"custom methods"})," by using ",(0,r.jsx)(t.em,{children:"built-in"})," function called ",(0,r.jsx)(t.code,{children:"Configure"}),".\nLet's ",(0,r.jsx)(t.em,{children:"configure"})," our ",(0,r.jsx)(t.em,{children:"custom method"})," to use an ",(0,r.jsx)(t.em,{children:"unreliable remote event"})," under the hood,\nso we can ",(0,r.jsx)(t.em,{children:"safely fire it"})," a lot of times."]}),"\n",(0,r.jsxs)(o.A,{groupId:"languages",children:[(0,r.jsx)(u.A,{value:"Luau",children:(0,r.jsx)(t.pre,{children:(0,r.jsx)(t.code,{className:"language-lua",metastring:'title="myEffect.lua" showLineNumbers',children:'local refx = require(path.to.refx)\nlocal myEffect = refx.CreateEffect("myEffect")\n\nfunction myEffect:OnConstruct()\n    self.DestroyOnEnd = false -- so our effect don\'t get destroyed instantly.\n    self.MaxLifetime = 10\nend\n\nfunction myEffect:DoSomething(arg) -- our custom method\n    print(arg)\nend\n\nrefx.Configure(myEffect.DoSomething, { -- configuring to use an unreliable remote\n    Unreliable = true,\n})\n\nreturn myEffect\n'})})}),(0,r.jsx)(u.A,{value:"TypeScript",default:!0,children:(0,r.jsx)(t.pre,{children:(0,r.jsx)(t.code,{className:"language-ts",metastring:'title="myEffect.ts" showLineNumbers',children:'import { BaseEffect, VisualEffectDecorator, Config } from "@rbxts/refx";\n\n@VisualEffectDecorator\nexport class myEffect extends BaseEffect {\n    protected readonly DestroyOnEnd = false; // so our effect don\'t get destroyed instantly.\n    protected readonly MaxLifetime = 10;\n\n    @Config({ Unreliable: true }) // configuring to use an unreliable remote\n    public DoSomething(arg: number) { // our custom method\n        print(arg);\n    }\n}\n'})})})]})]})}function m(e={}){const{wrapper:t}={...(0,a.R)(),...e.components};return t?(0,r.jsx)(t,{...e,children:(0,r.jsx)(f,{...e})}):f(e)}},9365:(e,t,n)=>{n.d(t,{A:()=>u});n(6540);var r=n(4164);const a={tabItem:"tabItem_Ymn6"};var o=n(4848);function u(e){let{children:t,hidden:n,className:u}=e;return(0,o.jsx)("div",{role:"tabpanel",className:(0,r.A)(a.tabItem,u),hidden:n,children:t})}},1470:(e,t,n)=>{n.d(t,{A:()=>E});var r=n(6540),a=n(4164),o=n(3104),u=n(6347),i=n(205),s=n(7485),l=n(1682),c=n(9466);function d(e){return r.Children.toArray(e).filter((e=>"\n"!==e)).map((e=>{if(!e||(0,r.isValidElement)(e)&&function(e){const{props:t}=e;return!!t&&"object"==typeof t&&"value"in t}(e))return e;throw new Error(`Docusaurus error: Bad <Tabs> child <${"string"==typeof e.type?e.type:e.type.name}>: all children of the <Tabs> component should be <TabItem>, and every <TabItem> should have a unique "value" prop.`)}))?.filter(Boolean)??[]}function f(e){const{values:t,children:n}=e;return(0,r.useMemo)((()=>{const e=t??function(e){return d(e).map((e=>{let{props:{value:t,label:n,attributes:r,default:a}}=e;return{value:t,label:n,attributes:r,default:a}}))}(n);return function(e){const t=(0,l.X)(e,((e,t)=>e.value===t.value));if(t.length>0)throw new Error(`Docusaurus error: Duplicate values "${t.map((e=>e.value)).join(", ")}" found in <Tabs>. Every value needs to be unique.`)}(e),e}),[t,n])}function m(e){let{value:t,tabValues:n}=e;return n.some((e=>e.value===t))}function h(e){let{queryString:t=!1,groupId:n}=e;const a=(0,u.W6)(),o=function(e){let{queryString:t=!1,groupId:n}=e;if("string"==typeof t)return t;if(!1===t)return null;if(!0===t&&!n)throw new Error('Docusaurus error: The <Tabs> component groupId prop is required if queryString=true, because this value is used as the search param name. You can also provide an explicit value such as queryString="my-search-param".');return n??null}({queryString:t,groupId:n});return[(0,s.aZ)(o),(0,r.useCallback)((e=>{if(!o)return;const t=new URLSearchParams(a.location.search);t.set(o,e),a.replace({...a.location,search:t.toString()})}),[o,a])]}function p(e){const{defaultValue:t,queryString:n=!1,groupId:a}=e,o=f(e),[u,s]=(0,r.useState)((()=>function(e){let{defaultValue:t,tabValues:n}=e;if(0===n.length)throw new Error("Docusaurus error: the <Tabs> component requires at least one <TabItem> children component");if(t){if(!m({value:t,tabValues:n}))throw new Error(`Docusaurus error: The <Tabs> has a defaultValue "${t}" but none of its children has the corresponding value. Available values are: ${n.map((e=>e.value)).join(", ")}. If you intend to show no default tab, use defaultValue={null} instead.`);return t}const r=n.find((e=>e.default))??n[0];if(!r)throw new Error("Unexpected error: 0 tabValues");return r.value}({defaultValue:t,tabValues:o}))),[l,d]=h({queryString:n,groupId:a}),[p,b]=function(e){let{groupId:t}=e;const n=function(e){return e?`docusaurus.tab.${e}`:null}(t),[a,o]=(0,c.Dv)(n);return[a,(0,r.useCallback)((e=>{n&&o.set(e)}),[n,o])]}({groupId:a}),g=(()=>{const e=l??p;return m({value:e,tabValues:o})?e:null})();(0,i.A)((()=>{g&&s(g)}),[g]);return{selectedValue:u,selectValue:(0,r.useCallback)((e=>{if(!m({value:e,tabValues:o}))throw new Error(`Can't select invalid tab value=${e}`);s(e),d(e),b(e)}),[d,b,o]),tabValues:o}}var b=n(2303);const g={tabList:"tabList__CuJ",tabItem:"tabItem_LNqP"};var v=n(4848);function x(e){let{className:t,block:n,selectedValue:r,selectValue:u,tabValues:i}=e;const s=[],{blockElementScrollPositionUntilNextRender:l}=(0,o.a_)(),c=e=>{const t=e.currentTarget,n=s.indexOf(t),a=i[n].value;a!==r&&(l(t),u(a))},d=e=>{let t=null;switch(e.key){case"Enter":c(e);break;case"ArrowRight":{const n=s.indexOf(e.currentTarget)+1;t=s[n]??s[0];break}case"ArrowLeft":{const n=s.indexOf(e.currentTarget)-1;t=s[n]??s[s.length-1];break}}t?.focus()};return(0,v.jsx)("ul",{role:"tablist","aria-orientation":"horizontal",className:(0,a.A)("tabs",{"tabs--block":n},t),children:i.map((e=>{let{value:t,label:n,attributes:o}=e;return(0,v.jsx)("li",{role:"tab",tabIndex:r===t?0:-1,"aria-selected":r===t,ref:e=>s.push(e),onKeyDown:d,onClick:c,...o,className:(0,a.A)("tabs__item",g.tabItem,o?.className,{"tabs__item--active":r===t}),children:n??t},t)}))})}function y(e){let{lazy:t,children:n,selectedValue:a}=e;const o=(Array.isArray(n)?n:[n]).filter(Boolean);if(t){const e=o.find((e=>e.props.value===a));return e?(0,r.cloneElement)(e,{className:"margin-top--md"}):null}return(0,v.jsx)("div",{className:"margin-top--md",children:o.map(((e,t)=>(0,r.cloneElement)(e,{key:t,hidden:e.props.value!==a})))})}function j(e){const t=p(e);return(0,v.jsxs)("div",{className:(0,a.A)("tabs-container",g.tabList),children:[(0,v.jsx)(x,{...t,...e}),(0,v.jsx)(y,{...t,...e})]})}function E(e){const t=(0,b.A)();return(0,v.jsx)(j,{...e,children:d(e.children)},String(t))}},8453:(e,t,n)=>{n.d(t,{R:()=>u,x:()=>i});var r=n(6540);const a={},o=r.createContext(a);function u(e){const t=r.useContext(o);return r.useMemo((function(){return"function"==typeof e?e(t):{...t,...e}}),[t,e])}function i(e){let t;return t=e.disableParentContext?"function"==typeof e.components?e.components(a):e.components||a:u(e.components),r.createElement(o.Provider,{value:t},e.children)}}}]);