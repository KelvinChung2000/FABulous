document.addEventListener("DOMContentLoaded", () => {
    const storageKey = "fabulous-docs-toc-collapsed";
    const manualStateKey = "fabulous-docs-toc-manual";
    const tocDrawer = document.querySelector(".toc-drawer");
    const tocTitleContainer = document.querySelector(".toc-title-container");
    const main = document.querySelector(".main");
    const article = document.querySelector("article[role='main']");

    if (!tocDrawer || !tocTitleContainer || !main || !article) {
        return;
    }

    const button = document.createElement("button");
    button.type = "button";
    button.className = "toc-collapse-toggle";
    button.setAttribute("aria-label", "Collapse page contents sidebar");
    button.innerHTML = '<span class="toc-collapse-toggle__icon" aria-hidden="true">❯</span>';
    tocTitleContainer.prepend(button);

    const getManualPreference = () => localStorage.getItem(manualStateKey);

    const isDesktopLayout = () => window.getComputedStyle(tocDrawer).position !== "fixed";

    const articleNeedsMoreWidth = () => {
        const tableWrappers = Array.from(
            article.querySelectorAll(".table-wrapper"),
        );

        if (
            tableWrappers.some(
                (wrapper) => wrapper.scrollWidth > wrapper.clientWidth + 2,
            )
        ) {
            return true;
        }

        return article.scrollWidth > article.clientWidth + 2;
    };

    const syncState = () => {
        const isDesktop = isDesktopLayout();
        const manualPreference = getManualPreference();
        const autoCollapsed = isDesktop && articleNeedsMoreWidth();
        const isCollapsed = isDesktop
            && (manualPreference === "collapsed"
                || (manualPreference !== "expanded" && autoCollapsed)
                || localStorage.getItem(storageKey) === "1");

        document.body.classList.toggle("toc-toggle-enabled", isDesktop);
        document.body.classList.toggle("toc-collapsed", isCollapsed);
        button.hidden = !isDesktop;
        button.setAttribute(
            "aria-label",
            isCollapsed
                ? "Expand page contents sidebar"
                : "Collapse page contents sidebar",
        );
        button.setAttribute("aria-expanded", String(!isCollapsed));
    };

    button.addEventListener("click", () => {
        const nextCollapsed = !document.body.classList.contains("toc-collapsed");
        localStorage.setItem(storageKey, nextCollapsed ? "1" : "0");
        localStorage.setItem(
            manualStateKey,
            nextCollapsed ? "collapsed" : "expanded",
        );
        syncState();
    });

    window.addEventListener("resize", syncState);
    window.addEventListener("load", syncState);

    const resizeObserver = new ResizeObserver(() => {
        syncState();
    });

    resizeObserver.observe(main);
    resizeObserver.observe(article);
    article.querySelectorAll(".table-wrapper").forEach((wrapper) => {
        resizeObserver.observe(wrapper);
    });

    syncState();
});
