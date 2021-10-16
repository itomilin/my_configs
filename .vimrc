syntax enable

" Преобразование Таба в пробелы
set expandtab

" Размер табуляции по умолчанию
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Всегда отображать статусную строку для каждого окна
set laststatus=2

" Включаем отображение дополнительной информации в статусной строке
set statusline=%<%f%h%m%r%=format=%{&fileformat}\ file=%{&fileencoding}\ enc=%{&encoding}\ %b\ 0x%B\ %l,%c%V\ %P

" Отключаем создание бэкапов
set nobackup

" Отключаем создание swap файлов
set noswapfile

"  Показывать номера строк
set number

" Включить подсветку синтаксиса
syntax on

" Поиск в процессе набора
set incsearch

" Подсвечивание результатов поиска
set hlsearch

" умная зависимость от регистра. Детали `:h smartcase`
set ignorecase
set smartcase

" Кодировка текста по умолчанию utf8
set termencoding=utf8

" Включаем несовместимость настроек с Vi, так как Vi нам и не понадобится
set nocompatible

" Показывать положение курсора всё время.
"set ruler

" Показывать незавершённые команды в статусбаре
set showcmd

" Фолдинг по отсупам
set foldenable
set foldlevel=100
set foldmethod=indent

" Поддержка мыши
"set mouse=a
"set mousemodel=popup

" Не выгружать буфер, когда переключаемся на другой
" Это позволяет редактировать несколько файлов в один и тот же момент без необходимости сохранения каждый раз
" когда переключаешься между ними
set hidden

" Скрыть панель в gui версии
set guioptions-=T

" Сделать строку команд высотой в одну строку
set ch=1

" Скрывать указатель мыши, когда печатаем
set mousehide

" Включить автоотступы
set autoindent

" Включаем перенос строк
"set wrap
""set nowrap " Не переносить

" Перенос строк по словам, а не по буквам
"set linebreak

" Формат строки состояния. Альтернативные варианты настройки `:h statusline`
"set statusline=%&lt;%f%h%m%r\ %b\ %{&amp;encoding}\ 0x\ \ %l,%c%V\ %P
"set laststatus=2

" Включаем "умные" отступы, например, авто отступ после `{`
"set smartindent

" Отображение парных символов
set showmatch

" Указание размеров окна редактора по умолчанию
"set lines=50
"set columns=140

" Навигация с учетом русских символов, учитывается командами следующее/предыдущее слово и т.п.
set iskeyword=@,48-57,_,192-255

" Подсвечивать линию текста, на которой находится курсор
"set cursorline
"highlight CursorLine guibg=lightblue ctermbg=lightgray
"highlight CursorLine term=none cterm=none

" Увеличение размера истории
set history=200

" Дополнительная информация в строке состояния
set wildmenu

" Настройка отображения специальных символов
set list listchars=tab:->\ ,trail:·

" wrap
set textwidth=80
if exists('&colorcolumn')
    set colorcolumn=+1
endif

imap { {}<LEFT>
imap [ []<LEFT>
