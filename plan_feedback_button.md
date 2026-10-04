# Handoff: anonymous site feedback through Microsoft Forms

## Decision

Replace the GitHub Issues design with a fixed **Give feedback** button on every
rendered HTML page. It opens an institution-owned Microsoft Form in a new tab.
Readers do not need a GitHub account or Microsoft sign-in. The form owner reviews
anonymous responses in Microsoft Forms or the linked Excel workbook later.

The Quarto site contains only a link, CSS, and a small optional clipboard helper.
It sends no data to an API and contains no token or tracking code. Microsoft Forms
provides the questions, validation, and institutional response storage.

Set the form audience to **Anyone can respond**. This accepts readers inside and
outside the institution without sign-in, and Microsoft Forms does not record their
names. The Microsoft 365 tenant must allow external Forms responses. Select
**Open in Excel** on the form's Responses tab to make the live response workbook:
it is in the owner's OneDrive for a personal form or the group's SharePoint site
for a group form.

Do not use GitHub Issues. Issue creation requires authentication and normally makes
the reporter's GitHub account public.

## Privacy boundary

Do not ask for names, email addresses, student numbers, assessment information, or
other personal data, and do not enable identity recording. Anonymous here means
that Forms does not record name or email. A reader can still identify themselves
in free text, and timestamps plus a very small audience may make a response
identifiable by inference. Say this in the form description.

Microsoft Forms does not have a documented, supported way to pre-fill questions
from arbitrary page URL parameters. The form therefore asks which page is
concerned. The button copies page title and a clean page URL for the reader to
paste into that optional question.

## Repository changes

| Path | Change |
|---|---|
| includes/feedback-widget.html | Fixed accessible link, page-context hint, and clipboard helper. |
| assets/feedback-widget.css | Fixed-control, responsive, focus, and print styling. |
| _quarto.yml | Global CSS and include-after-body registration. |

The shared _quarto.yml, not either build profile, is the correct location. Do not
change generated site files, GitHub issue templates, or every individual QMD page.

## 1. Create the Microsoft Form

1. Create it with an institutional Microsoft 365 work-or-school account. Confirm
   with the Microsoft 365 administrator that external Forms responses are enabled.
2. Choose ownership deliberately. A personal form puts the workbook in one
   author's OneDrive. A group form puts it in a group's SharePoint site and is
   preferable when ownership needs to survive staff changes.
3. Create a standard **Form** titled **Textbook feedback**.
4. Under the response audience, select **Anyone can respond**. Test its copied
   response URL from a private browser with no Microsoft sign-in.
5. Do not select **Only people in my organization can respond**: even with name
   recording off, it requires an institutional sign-in.

Use this description:

> Thank you for helping improve *Ecological Models and Data Analysis*. You can
> respond without signing in. We do not ask for your name, email address, student
> number, or other personal information. Please do not include personal,
> confidential, or assessment information. If only a few people could have sent
> a response, its time and details may still make it identifiable.

Add these questions:

| Required | Type | Question |
|---|---|---|
| Yes | Choice | **Feedback category**: Typo, grammar, or clarity; Mathematical or statistical error; R code error; Rendering, layout, or accessibility problem; Broken link, download, or other resource; Suggestion for the textbook; Other. |
| Yes | Text, long answer | **What should be changed?** State the typo, error, confusing passage, or suggestion as specifically as you can. |
| No | Text, long answer | **Which page is this about?** Paste the page title and web address. The feedback button copies them before opening this form when your browser permits it. |
| No | Text, long answer | **Steps to reproduce** For code or rendering problems, say what you did, expected, and observed. |
| No | Text, long answer | **Additional context** You can suggest replacement wording or include an exact error message. Do not include personal or confidential information. |

Leave **One response per person** off; it conflicts with public, no-sign-in
feedback. Set the confirmation message to:

> Thank you. Your anonymous feedback has been recorded. If you included a page
> address, we will use it to locate the material.

Use Collect responses and Copy link. Keep the full public response URL for the
website. Make a private-browser test response first. Check that the response view
and Excel export show no name or email, then delete the test if appropriate.

## 2. Create and protect the workbook

On the Responses tab, select Open in Excel. Record its OneDrive or SharePoint
location in private administrative documentation, not the public repository.
Restrict the form and workbook to named course maintainers.

Do not make or publish a Forms response-summary link: it can reveal aggregate
response information to anyone with that link. Keep analysis columns and triage
notes on another worksheet; preserve the live response table. A downloaded
workbook is a snapshot and does not receive future responses.

## 3. Add the global include

Create includes/feedback-widget.html. Replace
PASTE_THE_MICROSOFT_FORMS_RESPONSE_URL_HERE with the response URL, not an edit,
collaboration, results-summary, or Excel-workbook URL.

~~~html
<div class="book-feedback-widget">
  <a
    id="book-feedback-button"
    class="book-feedback-button"
    href="PASTE_THE_MICROSOFT_FORMS_RESPONSE_URL_HERE"
    target="_blank"
    rel="noopener"
    aria-describedby="book-feedback-context"
  >
    <span aria-hidden="true">&#128172;</span>
    Give feedback
  </a>
  <p id="book-feedback-context" class="book-feedback-context" role="status">
    Opens an anonymous Microsoft Form in a new tab.
  </p>
</div>

<script>
  (() => {
    const feedbackLink = document.getElementById("book-feedback-button");
    const feedbackContext = document.getElementById("book-feedback-context");

    if (!feedbackLink || !feedbackContext || !navigator.clipboard) {
      return;
    }

    feedbackLink.addEventListener("click", () => {
      const sourceUrl = new URL(window.location.href);
      sourceUrl.search = "";
      sourceUrl.hash = "";

      const pageContext =
        "Page title: " + document.title + "\nPage URL: " + sourceUrl;

      navigator.clipboard.writeText(pageContext).then(
        () => {
          feedbackContext.textContent =
            "Page title and URL copied. Paste them into the form if helpful.";
        },
        () => {
          feedbackContext.textContent =
            "Please paste this page's title and URL into the form if helpful.";
        }
      );
    });
  })();
</script>
~~~

This ordinary link works without JavaScript, is keyboard accessible, and preserves
the textbook in the original tab. Clipboard failure does not prevent form access.
Do not add an inline feedback textbox or category selector: it would force readers
to enter feedback twice.

## 4. Style the control

Create assets/feedback-widget.css:

~~~css
.book-feedback-widget {
  position: fixed;
  right: max(1rem, env(safe-area-inset-right));
  bottom: max(1rem, env(safe-area-inset-bottom));
  z-index: 1050;
}

.book-feedback-button {
  display: inline-flex;
  align-items: center;
  gap: 0.45rem;
  padding: 0.7rem 0.95rem;
  border: 2px solid #005A9C;
  border-radius: 999px;
  background: #0072B2;
  box-shadow: 0 0.2rem 0.65rem rgb(0 0 0 / 20%);
  color: #FFFFFF;
  font-weight: 600;
  line-height: 1.2;
  text-decoration: none;
}

.book-feedback-button:visited,
.book-feedback-button:focus-visible {
  color: #FFFFFF;
}

.book-feedback-button:hover {
  background: #005A9C;
  color: #FFFFFF;
  text-decoration: underline;
}

.book-feedback-button:focus-visible {
  outline: 3px solid #F0E442;
  outline-offset: 3px;
}

.book-feedback-context {
  position: absolute;
  width: 1px;
  height: 1px;
  margin: -1px;
  overflow: hidden;
  clip: rect(0 0 0 0);
  white-space: nowrap;
}

@media (max-width: 36rem) {
  .book-feedback-widget {
    right: 0.75rem;
    bottom: 0.75rem;
  }
}

@media print {
  .book-feedback-widget {
    display: none;
  }
}
~~~

## 5. Register it globally

Extend the existing format.html mapping in _quarto.yml, retaining its current
options:

~~~yaml
format:
  html:
    theme: cosmo
    toc: true
    number-sections: true
    css: assets/feedback-widget.css
    include-after-body: includes/feedback-widget.html
~~~

If include-after-body already exists, make it a YAML list and retain every include.
Do not place the setup in a profile-specific YAML file.

## 6. Validate

1. Check YAML syntax, render a representative page in both profiles, and inspect a
   home page and a deep practical for one copy of the include and CSS.
2. At desktop, 320 px, and tablet widths, check the button stays visible without
   covering navigation. Check a solutions page and print preview.
3. Tab to the button and verify visible focus, accessible name, Enter-key use,
   clear new-tab behaviour, and contrast.
4. Where clipboard access is allowed, verify it copies the current title and URL
   without query string or fragment. Verify the fallback still opens the form.
5. In a private browser without Microsoft authentication, test the deployed form
   from a home and deep page. It must not prompt for Microsoft or GitHub login.
6. Confirm that the Responses view and live workbook have no populated name or
   email values, export the questions correctly, and are not publicly shared.

## Maintenance

- Review Forms or its live Excel workbook on a regular course-maintenance schedule.
- For spam, use institutional Forms controls, temporarily close the form, or adopt
  a deliberate moderation policy. Requiring sign-in changes the promise to readers.
- If form ownership changes, recreate and recheck the form and workbook, then
  replace only the response URL in the include.

## References consulted

- [Microsoft Support: Send a form and collect responses](https://support.microsoft.com/en-us/forms/send-a-form-and-collect-responses)
- [Microsoft Support: Set up your survey so names are not recorded](https://support.microsoft.com/en-us/forms/set-up-your-survey-so-names-arent-recorded-when-collecting-responses)
- [Microsoft Learn: Administrator settings for Microsoft Forms](https://learn.microsoft.com/microsoft-forms/administrator-settings-microsoft-forms)
- [Microsoft Support: Microsoft Forms and Excel workbooks](https://support.microsoft.com/en-us/forms/microsoft-forms-and-excel-workbooks)
- [Microsoft Support: Check and share your form results](https://support.microsoft.com/en-us/forms/check-and-share-your-form-results)
